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
      wishes          = Wish.unscoped.find_by_user_id(user.id)
      votes           = Vote.unscoped.find_by_user_id(user.id)
      participations || events || materials || topics || wishes || votes
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

  desc "extracts data from cologne-rb"
  task :extract_cologne_data => [:environment] do
    [Authorization, Event, Location, Material, Participant, Topic, User, Vote, Wish].each do |model|
      puts "dumping #{model}"
      File.open("db/cologne_data/#{model.to_s.downcase}.json", "w:UTF-8") do |file|
        data = model.unscoped.all.map(&:attributes).map do |attrs|
          %w(id authorization_id event_id location_id material_id participant_id topic_id user_id vote_id wish_id).each do |id_column|
            attrs[id_column] = attrs[id_column] + 1000 if attrs[id_column]
          end
          attrs["label"] = "cologne" if [Event, Location, Wish].include?(model)
          attrs
        end
        JSON.dump(data, file)
      end
    end
  end

  desc "import extracted data from cologne-rb"
  task :import_cologne_data => [:environment] do
    Whitelabel.label = Whitelabel.label_for("cologne")
    [User, Authorization, Location, Event, Material, Participant, Topic, Wish, Vote].each do |model|
      puts "importing #{model}"
      model.where("id > 1000").delete_all
      entities = File.open("db/cologne_data/#{model.to_s.downcase}.json", "r:UTF-8") { |file| YAML.load(file)}
      entities.each do |attrs|
        begin
          model.create do |m|
            attrs.each { |key, value| m.send("#{key}=", value)}
          end
        rescue
          puts "could not import #{attrs} #{$!}"
        end
      end
    end
  end
end
