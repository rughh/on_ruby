class HomeController < ApplicationController
  expose(:current_event) { Event.current }
  expose(:events) { Event.limit(5).order('date DESC') }
  expose(:people) { User.scoped }
  expose(:main_user) { User.find_by_nickname(AppConfig.twitter) || User.find_by_nickname('phoet') }
  expose(:wishes) { Wish.scoped }
  expose(:organizers) { User.where(nickname: ['halfbyte', 'ralph', 'phoet', 'rubiii']) }
  expose(:locations) { Location.scoped }
  expose(:companies) { Location.where(company: true) }
end
