# frozen_string_literal: true

# Serves rubyevents.org-compatible YAML for the current usergroup.
class RubyeventsController < ApplicationController
  public def series
    render yaml: feed.series if stale_feed?
  end

  public def event
    render yaml: feed.event if stale_feed?
  end

  public def videos
    render yaml: feed.videos if stale_feed?
  end

  private def feed = @feed ||= Rubyevents::Feed.new(Whitelabel.label)

  private def stale_feed? = stale?(last_modified:)

  # Topics without an event are proposals: neither held nor scheduled, and so
  # absent from the feed. Counting them would invalidate a fetcher's cache for
  # content that has not changed. Materials do belong, since a talk's
  # slides_url comes from one.
  private def last_modified
    [
      Event.maximum(:updated_at),
      Topic.where.not(event_id: nil).maximum(:updated_at),
      Material.maximum(:updated_at)
    ].compact.max
  end
end
