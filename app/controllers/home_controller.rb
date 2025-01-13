# frozen_string_literal: true

class HomeController < ApplicationController
  expose(:current_event)    { Event.current.first }
  expose(:events)           { Event.latest.limit(10) }
  expose(:people)           { User.peers.limit(3 * 5) }
  expose(:undone_topics)    { Topic.ordered.undone }
  expose(:upcoming_topics)  { Topic.ordered.upcoming }
  expose(:done_topics)      { Topic.ordered.done.limit(10) }
  expose(:organizers)       { User.organizers }
  expose(:locations)        { Location.joins(:events).merge(Event.where(date: (2.years.ago.beginning_of_year)..)).distinct }
  expose(:zoom)             { Whitelabel[:location][:zoom] }

  def index; end
end
