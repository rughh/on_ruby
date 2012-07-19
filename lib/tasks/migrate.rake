namespace :migrate do
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
