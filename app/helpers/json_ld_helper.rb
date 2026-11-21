# frozen_string_literal: true

# Renders events as schema.org JSON-LD (https://schema.org/Event).
module JsonLdHelper
  CONTEXT = 'https://schema.org'
  # Every usergroup so far is in the eurozone (DE, ES, EE).
  CURRENCY = 'EUR'

  def json_ld_event_list(events)
    {
      '@context' => CONTEXT,
      '@type' => 'ItemList',
      'name' => I18n.tw('name'),
      'numberOfItems' => events.size,
      'itemListElement' => events.each_with_index.map do |event, index|
        { '@type' => 'ListItem', 'position' => index + 1, 'item' => json_ld_event_node(event) }
      end,
    }
  end

  def json_ld_event(event)
    { '@context' => CONTEXT }.merge(json_ld_event_node(event))
  end

  # Embeds the event for search engines. to_json escapes <, > and &, so descriptions can't close the script tag.
  def json_ld_event_script_tag(event)
    tag.script(json_ld_event(event).to_json.html_safe, type: 'application/ld+json') # rubocop:disable Rails/OutputSafety
  end

  private def json_ld_event_node(event)
    {
      '@type' => 'Event',
      '@id' => event_url(event),
      'url' => event_url(event),
      'name' => event.name,
      'description' => markdown_to_text(event.description),
      'image' => image_url(label_logo_asset),
      'startDate' => event.date.iso8601,
      'endDate' => event.end_date.iso8601,
      'eventStatus' => "#{CONTEXT}/EventScheduled",
      'eventAttendanceMode' => "#{CONTEXT}/#{json_ld_attendance_mode(event)}",
      'isAccessibleForFree' => true,
      'maximumAttendeeCapacity' => event.limit,
      'location' => json_ld_locations(event),
      'offers' => json_ld_offer(event),
      'organizer' => json_ld_organizer,
      'performer' => event.topics.filter_map(&:user).uniq.map { |user| json_ld_person(user) },
      'subEvent' => event.topics.map { |topic| json_ld_topic(topic, event) },
      'subjectOf' => event.materials.map { |material| json_ld_material(material) },
    }.compact_blank
  end

  private def json_ld_attendance_mode(event)
    if event.location&.virtual?
      'OnlineEventAttendanceMode'
    elsif event.remote_url.present?
      'MixedEventAttendanceMode'
    else
      'OfflineEventAttendanceMode'
    end
  end

  # remote_url is only shown to participants, so the virtual location points at the event page.
  private def json_ld_locations(event)
    locations = []
    locations << json_ld_location(event.location) if event.location
    locations << { '@type' => 'VirtualLocation', 'url' => event_url(event) } if json_ld_attendance_mode(event) == 'MixedEventAttendanceMode'
    locations
  end

  private def json_ld_location(location)
    return { '@type' => 'VirtualLocation', 'name' => location.name, 'url' => location_url(location) } if location.virtual?

    {
      '@type' => 'Place',
      '@id' => location_url(location),
      'name' => location.name,
      'url' => location.url,
      'address' => {
        '@type' => 'PostalAddress',
        'streetAddress' => [location.street, location.house_number].compact_blank.join(' '),
        'postalCode' => location.zip,
        'addressLocality' => location.city,
        'addressCountry' => Whitelabel.find_label(location.label).country_code,
      }.compact_blank,
      'geo' => json_ld_geo(location),
    }.compact_blank
  end

  private def json_ld_geo(location)
    return if location.lat.blank? || location.long.blank?

    { '@type' => 'GeoCoordinates', 'latitude' => location.lat, 'longitude' => location.long }
  end

  # Meetups are free; Google still expects an offer to show ticket information.
  private def json_ld_offer(event)
    {
      '@type' => 'Offer',
      'price' => 0,
      'priceCurrency' => CURRENCY,
      'availability' => "#{CONTEXT}/#{event.closed? ? 'SoldOut' : 'InStock'}",
      'url' => event_url(event),
    }
  end

  private def json_ld_organizer
    { '@type' => 'Organization', 'name' => I18n.tw('name'), 'url' => root_url }
  end

  private def json_ld_topic(topic, event)
    {
      '@type' => 'Event',
      '@id' => topic_url(topic),
      'url' => topic_url(topic),
      'name' => topic.name,
      'description' => markdown_to_text(topic.description),
      'startDate' => event.date.iso8601,
      'endDate' => event.end_date.iso8601,
      'location' => json_ld_locations(event),
      'performer' => json_ld_person(topic.user),
    }.compact_blank
  end

  private def json_ld_material(material)
    { '@type' => 'CreativeWork', 'name' => material.name, 'url' => material.url }
  end

  private def json_ld_person(user)
    return unless user

    { '@type' => 'Person', '@id' => user_url(user), 'name' => user.name, 'url' => user_url(user) }
  end
end
