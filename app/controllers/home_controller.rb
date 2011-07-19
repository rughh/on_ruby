class HomeController < ApplicationController
  expose(:current_event) { Event.current }
  expose(:events) { Event.last(5) }
  expose(:users) { User.all }
end
