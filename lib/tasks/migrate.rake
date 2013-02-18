namespace :migrate do
  desc "migrate topic data"
  task :topic_data => [:environment] do
    Whitelabel.labels.each do |label|
      puts "migrating with label #{label}"
      Whitelabel.label = label
      Event.all.each do |event|
        event.topics.each do |topic|
          puts "updating topic #{topic.id}"
          topic.label = label.label_id
          topic.save!
        end
      end
    end
    Topic.unscoped.find_each(&:save)
  end

  desc "delete inactive users"
  task :delete_inactive => [:environment] do
    Whitelabel.label = Whitelabel.label_for("hamburg")
    inactive = User.unscoped.reject do |user|
      participations  = Participant.unscoped.find_by_user_id(user.id)
      events          = Event.unscoped.find_by_user_id(user.id)
      materials       = Material.unscoped.find_by_user_id(user.id)
      topics          = Topic.unscoped.find_by_user_id(user.id)
      participations || events || materials || topics
    end
    inactive.map(&:delete)
  end

  desc "migrate data for login"
  task :add_login_column => [:environment] do
    Whitelabel.label = Whitelabel.label_for("hamburg")
    User.unscoped.each do |user|
      puts "migrate user with id #{user.id} to have twitter handle #{user.nickname}"
      user.update_attribute(:twitter, user.nickname) unless user.twitter
      user.update_attribute(:github, user.nickname) unless user.github
    end
  end
end
