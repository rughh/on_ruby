# frozen_string_literal: true

module SitemapsHelper
  def urls
    subdomain = Whitelabel[:label_id]

    topics    = Topic.ordered
    people    = User.peers
    events    = Event.ordered
    locations = Location.all

    urls = (topics + people + events + locations).map do |model|
      send :"#{model.class.to_s.downcase}_url", model, subdomain: subdomain
    end
    (urls + [root_url(subdomain: subdomain)]).flatten
  end
end
