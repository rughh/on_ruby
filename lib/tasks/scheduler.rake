desc "update geocoding"
namespace :scheduler do
  task update_geocoding: :environment do
    puts "updating all geocoding"
    locations = Location.unscoped.all
    locations.each do |location|
      location.geocode
      location.save!
      sleep(1) # rate limiting
    end
  end
end
