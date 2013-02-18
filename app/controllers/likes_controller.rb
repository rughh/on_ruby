class LikesController < ApplicationController
  before_filter :check_login, only: :create

  respond_to :json

  expose(:topic)
  expose(:like)

  def create
    unless topic.already_liked?(current_user)
      like.topic = topic
      like.user  = current_user
      like.save
    end

    respond_with(topic, like) do |format|
      format.json
    end
  end
end
