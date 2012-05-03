Usergroup = Struct.new :label_id, :name

Whitelabel.from_file Rails.root.join("config/whitelabel.yml")
