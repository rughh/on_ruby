# frozen_string_literal: true

namespace :scheduler do
  desc "update geocoding"
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

  desc "update previews"
  task update_preview: :environment do
    with_tracking do
      puts "updating previews"
      Whitelabel.each_label do
        Material.naked.each do |material|
          material.generate_preview
          sleep(1) # rate limiting
        end
      end
    end
  end

  private

  def with_tracking
    yield
  rescue => e
    ExceptionNotifier.notify_exception(e) if Rails.env.production?
    Rails.logger.error("exception during task invocation: #{e}\n#{e.backtrace.join("\n")}")
  end
end
