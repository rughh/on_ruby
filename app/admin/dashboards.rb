ActiveAdmin::Dashboards.build do

  section "Recent Events" do
    ul do
      Event.latest.collect do |event|
        li link_to(event.name, admin_event_path(event))
      end
    end
  end
  
  section "Unpublished Events" do
    ul do
      Event.unpublished.collect do |event|
        li link_to("Publizieren: #{event.name}", publish_admin_event_path(event))
      end
    end
  end

end
