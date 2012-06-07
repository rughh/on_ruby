Usergroup = Struct.new :label_id, :email, :host, :twitter, :usergroup_email, :organizers, :location, :imprint, :other_usergroups

Whitelabel.from_file Rails.root.join("config/whitelabel.yml")
