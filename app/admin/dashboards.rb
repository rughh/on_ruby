ActiveAdmin::Dashboards.build do

  section "Event Stuff" do
    ul do
      li link_to 'Dup latest Event', duplicate_admin_events_path
    end
    ul do
      Event.unpublished.collect do |event|
        li link_to("Publish: #{event.name}", publish_admin_event_path(event))
      end
    end
  end

  section "Open Wishes" do
    ul do
      Wish.undone.collect do |wish|
        li link_to("Topic for next Event for: #{wish.name}", copy_admin_wish_path(wish))
      end
    end
  end
end
