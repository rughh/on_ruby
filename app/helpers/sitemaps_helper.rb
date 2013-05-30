module SitemapsHelper
  def urls(p = params[:id])
    label = Whitelabel.label_for(p)
    Whitelabel.with_label(label) do
      subdomain = label.label_id

      topics    = Topic.ordered
      people    = User.peers
      events    = Event.ordered
      locations = Location.all

      (topics + people + events + locations).map do |model|
        send :"#{model.class.to_s.downcase}_url", model, subdomain: subdomain
      end + [root_url(subdomain: subdomain)]
    end.flatten
  end
end
