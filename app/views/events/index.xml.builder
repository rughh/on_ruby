xml.instruct!

xml.rss "version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/" do
 xml.channel do
   xml.title       "#{I18n.tw('title')} Feed"
   xml.link        url_for only_path: false, controller: 'events'
   xml.description "Aktuelle #{I18n.tw('name')} Events"

   events.each do |event|
     xml.item do
       xml.title       l(event.date) + ' ' + event.name
       xml.link        url_for only_path: false, controller: 'events', action: 'show', id: event.id
       xml.description event.description
       xml.guid        url_for only_path: false, controller: 'events', action: 'show', id: event.id
     end
   end
 end
end
