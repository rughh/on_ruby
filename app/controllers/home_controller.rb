class HomeController < ApplicationController
  expose(:current_event) { Event.current.first }
  expose(:events) { Event.latest }
  expose(:people) { User.peers }
  expose(:undone_topics) { Topic.ordered.undone }
  expose(:organizers) { User.organizers }
  expose(:locations)

  def labels
    render layout: "labels"
  end
end
