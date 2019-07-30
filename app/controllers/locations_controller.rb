# typed: true
class LocationsController < ApplicationController
  expose(:location, find: ->(id, scope) { scope.find_by_slug(id) })
  expose(:locations)  { Location.ordered }
  expose(:organizers) { User.organizers }
  expose(:stats)      { Event.stats }

  def index; end

  def show; end

  def none; end
end
