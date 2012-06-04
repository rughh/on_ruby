Usergroup = Struct.new :label_id, :location

Whitelabel.from_file Rails.root.join("config/whitelabel.yml")
