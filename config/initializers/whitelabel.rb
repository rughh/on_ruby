Usergroup = Struct.new :label_id, :email, :host, :twitter, :usergroup_email, :organizers, :location

Whitelabel.from_file Rails.root.join("config/whitelabel.yml")
