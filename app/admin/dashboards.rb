ActiveAdmin::Dashboards.build do
  section "Event Stuff" do
    ul do
      li link_to 'Duplicate latest Event', duplicate_admin_events_path
    end
    ul do
      Event.unpublished.collect do |event|
        item = event.name + ": " + link_to("tweet", twitter_helper.twitter_update_url(event.twitter_message(event_url(event)))) + " / " + link_to("publish", publish_admin_event_path(event))
        li raw(item)
      end
    end
  end

  section "Open Wishes" do
    ul do
      Wish.undone.collect do |wish|
        item = wish.name + ": " + link_to("tweet", twitter_helper.twitter_update_url(wish.twitter_message(wish_url(wish)))) + " / " + link_to("for next Event", copy_admin_wish_path(wish))
        li raw(item)
      end
    end
  end
end

def twitter_helper
  helper = Object.new
  helper.send :extend, ApplicationHelper
  helper
end
