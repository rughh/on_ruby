# frozen_string_literal: true

module Rubyevents
  # Maps a usergroup onto the YAML documents rubyevents.org expects.
  class Feed
    LANGUAGES = { 'de' => 'German', 'en' => 'English', 'es' => 'Spanish', 'pl' => 'Polish' }.freeze
    COUNTRIES = { 'DE' => 'Germany', 'ES' => 'Spain', 'EE' => 'Estonia' }.freeze

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

    public def videos = []

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
  end
end
