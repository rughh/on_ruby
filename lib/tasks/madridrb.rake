# Encoding: utf-8
require 'yaml'

namespace :madridrb do

  LOCATION_ALIASES = {
    "Lugar: Aula The Cocktail" => "Aula The Cocktail",
    "Polideportivo La Elipa, pista 1-A (entrada por calle Alcalde Garrido Juaristi)" => "Polideportivo La Elipa",
    "Terraza Valle HermosoRibera de Curtidores, 28" => "Terraza Valle Hermoso",
    "The Irish Rover @ Avenida de Brasil, 7" => "The Irish Rover Madrid",
    "The Irish Rover" => "The Irish Rover Madrid",
    "Utopic_US" => "Utopic_US US1",
    "Utopic_US (map)" => "Utopic_US US1",
    "Utopic_US, Calle de la Concepción Jerónima 22, Madrid." => "Utopic_US US1",
    "Utopic_US, Calle Duque de Rivas 5, Madrid." => "Utopic_US US2",
    "Utopic_US US3 (c/ Colegiata 9)" => "Utopic_US US3",
  }

  def find_location(location_name)
    location_name = LOCATION_ALIASES[location_name] || location_name
    Location.where(name: location_name).first!
  end

  def find_user_by_twitter(handle)
    handle = handle.split.first.strip
    handle = handle[1..-1] if handle[0] == '@'
    User.where('lower(twitter) = ?', handle.downcase).first
  end

  def update_speaker(speaker_attrs)
    description = speaker_attrs['speaker_bio_md']
    twitter     = speaker_attrs['speaker_handle']
    url         = speaker_attrs['speaker_url']

    speaker = find_user_by_twitter(twitter)
    raise "Could not find speaker #{twitter}!" unless speaker

    speaker.url         = url         unless speaker.url.present?
    speaker.description = description unless speaker.description.present?
    speaker.save
    speaker
  end


  desc "sets the label to madrid"
  task set_label: :environment do
    Whitelabel.label = Whitelabel.label_for(:madridrb)

    Time.zone = Whitelabel[:default_time_zone]
    I18n.locale = Whitelabel[:default_locale]
  end

  namespace :import do

    desc "imports users from ./data/madridrb-users.yml"
    task users: 'madridrb:set_label' do
      users_attrs = YAML.load_file File.join(File.dirname(__FILE__), 'data','madridrb-users.yml')

      users_attrs.each do |attrs|
        user = find_user_by_twitter(attrs[:twitter])
        unless user
          puts "Creating #{attrs[:name]}"
          user = User.create(attrs)
        end
        puts user.errors.inspect unless user.valid?
      end
    end

    desc "imports locations from ./data/madridrb-locations.yml"
    task locations: 'madridrb:set_label' do
      locations_attrs = YAML.load_file File.join(File.dirname(__FILE__), 'data','madridrb-locations.yml')

      locations_attrs.each do |attrs|
        Location.find_or_create_by(name: attrs[:name]) do |loc|
          puts "Creating #{attrs[:name]}"
          loc.assign_attributes(attrs)
        end
      end
    end


    desc "imports data from ./data/madridrb-meetings.yml"
    task meetings: ['madridrb:import:locations', 'madridrb:import:users'] do

      admin_user = find_user_by_twitter('otikik')

      event_attrs = YAML.load_file File.join(File.dirname(__FILE__), 'data', 'madridrb-meetings.yml')

      lost_attendees = []

      event_attrs.each do |attrs|
        location = find_location(attrs['venue'] || "Utopic_US US1")

        time_string = attrs['meeting_time'] || '19:30'
        date_string = "#{attrs['meeting_date']}T#{time_string}"
        date = DateTime.iso8601(date_string).in_time_zone
        month_name = I18n.t('date.month_names')[date.month].capitalize
        event_name = "#{month_name} #{date.year}"
        event = Event.find_or_create_by(name: event_name) do |e|
          puts "Creating #{event_name}"
          e.assign_attributes({
            name: event_name,
            description: "Reunión de Madrid.rb de #{month_name} #{date.year}",
            date: date,
            location_id: location.id,
            user_id: admin_user.id
          })
        end
        puts event.errors.inspect unless event.valid?

        (attrs['topics'] or []).each do |topic_attrs|
          speakers = topic_attrs['speakers'].collect do |speaker_attrs|
            update_speaker(speaker_attrs)
          end

          speaker     = speakers.first || admin_user
          name        = topic_attrs['title']
          description = topic_attrs['details_md']
          video_url   = topic_attrs['video_url']

          topic = Topic.find_or_create_by(name: name, event_id: event.id) do |t|
            puts "Creating #{name}"
            t.assign_attributes(
              user_id: speaker.id,
              description: description,
              proposal_type: "proposal"
            )
          end
          puts topic.errors.inspect unless topic.valid?

          if video_url.present? then
            m = Material.find_or_create_by(url: video_url, name: "Vídeo", event_id: event.id, user_id: admin_user.id)
            puts m.errors.inspect unless m.valid?
          end
        end


        (attrs['attendees'] or []).each do |handle|
          attendee = find_user_by_twitter(handle)
          if attendee
            Participant.create(user: attendee, event: event)
          else
            lost_attendees << handle
          end
        end
      end

      puts "Lost members: #{lost_attendees.compact.uniq.sort.join ','}"

    end
  end
end
