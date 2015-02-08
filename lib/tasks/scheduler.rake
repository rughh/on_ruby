desc "update geocoding"
namespace :scheduler do
  task update_geocoding: :environment do
    with_tracking do
      puts "updating all geocoding"
      Whitelabel.each_label do
        Location.all.each do |location|
          location.geocode
          location.save!
          sleep(1) # rate limiting
        end
      end
    end
  end

  private

  def with_tracking
    begin
      yield
    rescue => e
      ExceptionNotifier.notify_exception(e) if Rails.env.production?
      Rails.logger.error("exception during task invocation: #{e}\n#{e.backtrace.join("\n")}")
    end
  end
end
