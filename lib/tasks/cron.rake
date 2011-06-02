desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
  logger = Rails.logger
  logger.debug "executing cron at #{Time.now}"
  User.all.each do |user|
    logger.debug "checking friendship status of #{user.nickname}"
    unless Twitter.friendship(:source_screen_name => "hamburgsync", :target_screen_name => user.nickname).source.following
      logger.debug "now following #{user.nickname}"
      Twitter.follow(user.nickname)
    end
  end
end