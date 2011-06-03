desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
  puts "executing cron at #{Time.now}"
  User.all.each do |user|
    puts "checking friendship status of #{user.nickname}"
    next if user.nickname == AppConfig.twitter
    next if Twitter.user(user.nickname).protected
    
    friendship = Twitter.friendship(:source_screen_name => AppConfig.twitter, :target_screen_name => user.nickname)
    unless friendship.source.following
      puts "now following #{user.nickname}"
      Twitter.follow(user.nickname)
    end
  end
end