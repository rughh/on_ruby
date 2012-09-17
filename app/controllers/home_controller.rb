class HomeController < ApplicationController
  skip_before_filter :switch_label, only: :labels
  skip_before_filter :switch_locale, only: :labels

  caches_action :index, layout: false, expires_in: 6.hours

  expose(:current_event) { Event.current.first }
  expose(:events) { Event.latest }
  expose(:people) { User.peers }
  expose(:wishes_undone) { Wish.undone }
  expose(:wishes_done) { Wish.done }
  expose(:organizers) { User.organizers }
  expose(:locations) { Location.cometogether }
  expose(:companies) { Location.company }

  def labels
    flash.now[:alert] = t("flash.no_whitelabel")
    render :layout => 'labels'
  end
end
