desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
  logger = Rails.logger
  logger.debug "executing cron at #{Time.now}"
  requested = Twitter.friendships_outgoing
  logger.debug "already requested friendships to #{requested}"
  User.all.each do |user|
    logger.debug "checking friendship status of #{user.nickname}"
    next if user.nickname == AppConfig.twitter
    friendship = Twitter.friendship(:source_screen_name => AppConfig.twitter, :target_screen_name => user.nickname)
    if requested.include?(friendship.target.id)
      logger.debug "skipping #{user.nickname}, already requested"
    else friendship.source.following
      logger.debug "now following #{user.nickname}"
      Twitter.follow(user.nickname)
    end
  end
end