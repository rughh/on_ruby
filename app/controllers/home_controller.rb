class HomeController < ApplicationController
  expose(:current_event) { Event.current.first }
  expose(:events) { Event.latest }
  expose(:people) { User.peers }
  expose(:wishes_undone) { Wish.by_status(:undone) }
  expose(:wishes_done) { Wish.by_status(:done) }
  expose(:organizers) { User.organizers }
  expose(:locations)

  def labels
    flash.now[:alert] = t("flash.no_whitelabel")
    render layout: "labels"
  end
end
