ActiveAdmin::Dashboards.build do

  section "Recent Events" do
    ul do
      Event.preview_events.collect do |event|
        li link_to(event.name, admin_event_path(event))
      end
    end
  end

end
