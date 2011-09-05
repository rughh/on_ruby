ActiveAdmin::Dashboards.build do

  section "Unpublished Events" do
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
