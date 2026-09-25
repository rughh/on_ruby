# frozen_string_literal: true

module Rubyevents
  # Maps a usergroup onto the YAML documents rubyevents.org expects.
  class Feed
    LANGUAGES = { 'de' => 'German', 'en' => 'English', 'es' => 'Spanish', 'pl' => 'Polish' }.freeze
    COUNTRIES = { 'DE' => 'Germany', 'ES' => 'Spain', 'EE' => 'Estonia' }.freeze

    # Psych escapes U+2028/U+2029 as \L and \P, but rubyevents' formatter
    # un-escapes them into a literal block scalar, where they act as real line
    # breaks and produce unparseable YAML. They are invisible paste artefacts,
    # so normalise them to a plain newline before they reach the document.
    LINE_SEPARATORS = /[\u2028\u2029]/

    # rubyevents re-emits speaker names as plain scalars, and YAML forbids a
    # plain scalar from opening with an indicator character. Anyone can sign
    # up with such a display name, so prefer the nickname over the name when
    # the name would produce a document their own seeder cannot parse.
    LEADING_INDICATOR = /\A[-?:,\[\]{}#&*!|>'"%@`]+/

    # Their SpeakerSchema wants bare handles, but our linkedin column holds a
    # mix of handles and full profile URLs.
    LINKEDIN_HANDLE = %r{(?:^|linkedin\.com/in/)([^/\s]+)/?\z}

    def initialize(whitelabel)
      @whitelabel = whitelabel
    end

    public def series
      scoped do
        {
          'id' => series_id,
          'name' => name,
          'kind' => 'meetup',
          'frequency' => frequency,
          'language' => LANGUAGES[whitelabel.default_locale],
          'default_country_code' => whitelabel.country_code,
          'website' => whitelabel.canonical_url,
          'twitter' => whitelabel.twitter,
          'bsky' => whitelabel.bluesky,
          'github' => github_url,
        }.compact_blank
      end
    end

    public def event
      scoped do
        {
          'id' => event_id,
          'title' => name,
          'kind' => 'meetup',
          'location' => location,
          'timezone' => whitelabel.default_time_zone,
          'coordinates' => coordinates,
          'website' => whitelabel.canonical_url,
          'description' => description,
        }.compact_blank
      end
    end

    public def videos
      scoped { events.map { |event| edition(event) } }
    end

    # rubyevents keeps one global data/speakers.yml, so this is not a drop-in
    # file. It carries the handles their entries need: without them every
    # speaker we introduce arrives anonymous and may collide with an existing
    # profile on slug alone.
    public def speakers
      scoped do
        events.flat_map { |event| event.topics.map(&:user) }
              .uniq(&:id)
              .sort_by(&:id)
              .map { |user| speaker_profile(user) }
      end
    end

    private attr_reader :whitelabel

    # I18n.tw and the Event/Topic default scopes both read the label from the
    # current thread, so pin it to ours for the duration of the lookup.
    private def scoped(&) = Whitelabel.with_label(whitelabel, &)

    private def series_id = whitelabel.label_id.dasherize

    private def tw(token) = I18n.tw(token, locale: :en)

    private def name = tw('name')

    private def frequency = whitelabel.recurring.present? ? 'monthly' : nil

    private def github_url
      return if whitelabel.github_org.blank?

      "https://github.com/#{whitelabel.github_org}"
    end

    private def event_id = "#{series_id}-meetup"

    private def location = "#{tw('city')}, #{COUNTRIES.fetch(whitelabel.country_code)}"

    private def coordinates
      { 'latitude' => whitelabel.location[:lat], 'longitude' => whitelabel.location[:long] }
    end

    # Every label carries its own meta_desc today. Should one ever fall back,
    # the default describes German usergroups and would be wrong elsewhere.
    private def description
      meta_desc = tw('meta_desc')
      return if meta_desc == I18n.t('label.default.meta_desc', locale: :en)

      meta_desc
    end

    # Oldest first: rubyevents orders videos.yml chronologically ascending,
    # unlike our own Event.ordered scope.
    private def events
      Event.includes(topics: %i[user materials]).order(date: :asc)
    end

    private def edition(event)
      talks = event.topics.sort_by(&:id).map { |topic| talk(topic, event) }

      {
        'id' => edition_id(event),
        'video_id' => edition_id(event),
        'title' => event.name,
        'event_name' => event.name,
        'description' => text(event.description),
        'date' => event.date.to_date.iso8601,
        'video_provider' => talks.any? ? 'children' : 'not_recorded',
      }.compact_blank.merge('talks' => talks)
    end

    private def talk(topic, event)
      {
        'id' => talk_id(topic, event),
        'video_id' => talk_id(topic, event),
        'title' => topic.name,
        'description' => text(topic.description),
        'date' => event.date.to_date.iso8601,
        'event_name' => event.name,
        'speakers' => [speaker(topic)],
        'video_provider' => event.date.future? ? 'scheduled' : 'not_recorded',
        'slides_url' => topic.materials.first&.url,
      }.compact_blank
    end

    # Ids come from primary keys, never names: rubyevents upserts on id, and a
    # renamed event or topic would otherwise look like a record that vanished.
    private def edition_id(event) = "#{series_id}-event-#{event.id}"

    private def talk_id(topic, event) = "#{edition_id(event)}-topic-#{topic.id}"

    private def speaker(topic) = speaker_name(topic.user)

    private def speaker_name(user)
      [user.name, user.nickname].find { |it| it.present? && !it.match?(LEADING_INDICATOR) } ||
        user.name.sub(LEADING_INDICATOR, '').presence ||
        user.nickname.sub(LEADING_INDICATOR, '')
    end

    private def text(value) = value&.gsub(LINE_SEPARATORS, "\n")

    private def speaker_profile(user)
      # github is the only required handle, so it survives compaction as an
      # empty string while the optional ones drop out.
      name = speaker_name(user)

      {
        'name' => name,
        'slug' => name.parameterize,
        'twitter' => user.twitter,
        'linkedin' => linkedin_handle(user),
        'website' => user.url,
      }.compact_blank.merge('github' => user.github.to_s.downcase)
    end

    private def linkedin_handle(user) = user.linkedin&.[](LINKEDIN_HANDLE, 1)
  end
end
