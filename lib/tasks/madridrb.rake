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

  desc "sets the label to madrid"
  task set_label: :environment do
    Whitelabel.label = Whitelabel.label_for(:madridrb)

    Time.zone = Whitelabel[:default_time_zone]
    I18n.locale = Whitelabel[:default_locale]
  end

  namespace :import do

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
    task meetings: 'madridrb:import:locations' do

      event_attrs = YAML.load_file File.join(File.dirname(__FILE__), 'data', 'madridrb-meetings.yml')

      admin_user = User.where(email: 'kikito@gmail.com').first!

      event_attrs.each do |attrs|
        location = find_location(attrs['venue'] || "Utopic_US US1")

        time_string = attrs['meeting_time'] || '19:30'
        date_string = "#{attrs['meeting_date']}T#{time_string}"
        date = DateTime.iso8601(date_string).in_time_zone
        month_name = I18n.t('date.month_names')[date.month].capitalize
        event_name = "#{month_name} #{date.year}"
        ev = Event.find_or_create_by(name: event_name) do |e|
          puts "Creating #{event_name}"
          e.assign_attributes({
            name: event_name,
            description: "Reunión de Madrid.rb de #{month_name} #{date.year}",
            date: date,
            location_id: location.id,
            user_id: admin_user.id
          })
        end
        puts ev.errors.inspect unless ev.valid?
      end
    end
  end
end
