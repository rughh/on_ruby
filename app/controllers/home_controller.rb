class HomeController < ApplicationController
  expose(:current_event)  { Event.current.first }
  expose(:events)         { Event.latest.limit(10) }
  expose(:people)         { User.peers }
  expose(:undone_topics)  { Topic.ordered.undone }
  expose(:upcoming_topics){ Topic.ordered.upcoming }
  expose(:done_topics)    { Topic.ordered.done.limit(10) }
  expose(:organizers)     { User.organizers }
  expose(:locations)

  def index; end
end
