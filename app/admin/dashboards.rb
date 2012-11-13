ActiveAdmin.register_page "Dashboard" do

  action_item do
    link_to 'Duplicate latest Event', duplicate_admin_events_path
  end

  content do
    h2 "Event Actions"
    ul do
      Event.unpublished.collect do |event|
        item = event.name + ": " + link_to("tweet", twitter_update_url(event)) + " / " + link_to("publish", publish_admin_event_path(event))
        li raw(item)
      end
    end

    h2 "Wish Actions"
    ul do
      Wish.by_status(:undone).collect do |wish|
        item = wish.name + ": " + link_to("tweet", twitter_update_url(wish)) + " / " + link_to("for next Event", copy_admin_wish_path(wish))
        li raw(item)
      end
    end

    h2 "Highlight Actions"
    ul do
      Highlight.active.collect do |highlight|
        li link_to "Disable '#{highlight.description}'", disable_admin_highlight_path(highlight)
      end
    end
  end
end
