# ecoding: utf-8
Whitelabel.label = Whitelabel.labels.first

if Location.all.empty?
  locations = Location.create(
    [
      {
        :name => 'blau Mobilfunk GmbH',
        :url => 'http://www.blaumobilfunk.de',
        :street => 'Schulterblatt',
        :house_number => '124',
        :city => 'Hamburg',
        :zip => '20357',
        :lat => 53.56544,
        :long => 9.95947
      }
    ]
  )
end

if User.all.empty?
  auth_hash = {
    "provider"=>"twitter",
    "uid"=>"14339524",
    "info"=>{
      "nickname"=>"phoet",
      "name"=>"Peter Schröder",
      "location"=>"Sternschanze, Hamburg",
      "image"=>"http://a3.twimg.com/profile_images/1100439667/P1040913_normal.JPG",
      "description"=>"I am a freelance Ruby and Java developer from Hamburg, Germany. ☠ nofail",
      "urls"=>{"Website"=>"http://nofail.de"}
    }
  }
  Authorization.create_from_hash(auth_hash)
  User.update_all(admin: true)
end

if Event.all.empty?
  Event.create do |event|
    event.name = 'Rails Usergroup Hamburg — Weihnachtstreffen'
    event.date = DateTime.parse('2010/12/08 19:00')
    event.description = 'Die Hamburger Usergroup trifft sich an jedem 2. Mittwoch des Monats an unterschiedlichen Orten. Das Dezember-Treffen findet bei blau.de Mobilfunk in der Schanze statt. Da es sich um das Weihnachtstreffen handelt, wird es Glühwein, Gebäck und Liederzettel geben.'
    event.user = User.first
    event.location = Location.first
  end
end

if Participant.all.empty?
  Participant.create do |p|
    p.user = User.first
    p.event = Event.first
  end
end

puts "\nAlternatively you can use the taps gem to retrieve\na dump of test-data from heruko: 'heroku db:pull'\n"
