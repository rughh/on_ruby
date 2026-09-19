# Seeds a minimal, self-contained dev dataset (no Heroku access required):
# an admin user, a normal user, a location, an event and a topic, all for
# the "hamburg" usergroup. Safe to run multiple times.
#
#   bin/rails db:seed
#
# See readme.md > "Users Login" for how to log in as these users locally.

label = Whitelabel.label_for('hamburg')

Whitelabel.with_label(label) do
  admin = User.find_or_create_by!(nickname: 'admin') do |user|
    user.name        = 'Admin'
    user.image       = 'http://www.onruby.de/assets/labels/hamburg.png'
    user.admin       = true
    user.super_admin = true
  end
  admin.authorizations.find_or_create_by!(provider: 'seed', uid: 'admin')

  user = User.find_or_create_by!(nickname: 'demo') do |demo|
    demo.name  = 'Demo User'
    demo.image = 'http://www.onruby.de/assets/labels/hamburg.png'
  end
  user.authorizations.find_or_create_by!(provider: 'seed', uid: 'demo')

  # real location, so we can geocode it
  location = Location.find_or_create_by!(name: 'Seeded Location', label: label.label_id) do |loc|
    loc.url          = 'http://example.com'
    loc.street       = 'Platz d. Deutschen Einheit'
    loc.house_number = '4'
    loc.city         = 'Hamburg'
    loc.zip          = '20457'
  end

  event = Event.find_or_create_by!(name: 'Seeded Event', label: label.label_id) do |ev|
    ev.date        = 1.week.from_now
    ev.description = 'A seeded event for local development.'
    ev.location    = location
    ev.user        = admin
  end

  Topic.find_or_create_by!(name: 'Seeded Topic', label: label.label_id) do |topic|
    topic.description   = 'A seeded topic for local development.'
    topic.proposal_type = 'proposal'
    topic.event         = event
    topic.user          = user
  end

  puts '*' * 100
  puts "Seeded #{label.label_id} with an admin, a user, a location, an event and a topic."
  puts 'Log in as admin (dev only):      /auth/offline_login/admin'
  puts 'Log in as demo user (dev only):  /auth/offline_login/demo'
  puts '*' * 100
end
