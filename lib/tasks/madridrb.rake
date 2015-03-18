# Encoding: utf-8
require 'yaml'

namespace :madridrb do

  LOCATION_ALIASES = {
    "Lugar: Aula The Cocktail" => "Aula The Cocktail",
    "Polideportivo La Elipa, pista 1-A (entrada por calle Alcalde Garrido Juaristi)" => "Polideportivo La Elipa",
    "Terraza Valle HermosoRibera de Curtidores, 28" => "Terraza Valle Hermoso",
    "The Irish Rover @ Avenida de Brasil, 7" => "The Irish Rover",
    "Utopic_US" => "Utopic_US US1",
    "Utopic_US (map)" => "Utopic_US US1",
    "Utopic_US, Calle de la Concepción Jerónima 22, Madrid." => "Utopic_US US1",
    "Utopic_US, Calle Duque de Rivas 5, Madrid." => "Utopic_US US2",
    "Utopic_US US3 (c/ Colegiata 9)" => "Utopic_US US3",
  }

  def get_location(location_name)
    location_name = LOCATION_ALIASES[location_name] || location_name
    # Todo: find location by name or error
  end

  def import_event(event_info)
    date_string = "#{event_info['meeting_date']}T#{event_info['meeting_time']}"
    date = DateTime.iso8601(date_string).in_time_zone
    month_name = I18n.t('date.month_names')[date.month].capitalize
    event = Event.new(
      name: "#{month_name} #{date.year}",
      description: "Reunión de Madrid.rb de #{month_name} #{date.year}",
      date: date
    )
    puts event.attributes
  end




  desc "imports data from ./data/madridrb.yml"
  task import: :environment do

    locations = YAML.load_file File.join(File.dirname(__FILE__), 'data','madridrb-locations.yml')
    # todo: create locations if not existing
    meetings = YAML.load_file File.join(File.dirname(__FILE__), 'data', 'madridrb-meetings.yml')

    Whitelabel.label = Whitelabel.label_for(:madridrb)

    Time.zone = Whitelabel[:default_time_zone]
    I18n.locale = Whitelabel[:default_locale]

    puts(meetings.collect do |x|
      LOCATION_ALIASES[x['venue']] || x['venue']
    end.uniq.compact.sort)
  end
end
