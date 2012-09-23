class MiscController < ApplicationController
  skip_before_filter :switch_label, only: :sitemap

  helper_method :urls
  respond_to :xml
  layout :false

  def sitemap; end

  private

  def urls
    Whitelabel.labels.map do |label|
      Whitelabel.with_label(label) do
        subdomain = label.label_id
        wishes    = Wish.all.map { |wish| wish_url wish, subdomain: subdomain }
        users     = User.all.map { |user| user_url user, subdomain: subdomain }
        events    = Event.all.map { |event| event_url event, subdomain: subdomain }
        locations = Location.all.map { |location| location_url location, subdomain: subdomain }
        [root_url(subdomain: subdomain)] + wishes + events + users + locations
      end
    end.flatten
  end
end
