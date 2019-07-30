# typed: true
class LikesController < ApplicationController
  before_action :authenticate!

  expose(:topic, find: ->(id, scope) { scope.find_by_slug(id) })
  expose(:like)

  def create
    like.topic = topic
    like.user = current_user
    if topic.already_liked?(current_user)
      flash[:alert] = t('flash.double_liked')
    elsif like.save
      flash[:notice] = t('flash.liked')
    else
      flash[:alert] = like.errors.full_messages.join(' ')
    end
    redirect_to topic_path(topic)
  end

  def destroy
    if topic.already_liked?(current_user) && like.destroy
      flash[:notice] = t('flash.unliked')
    else
      flash[:alert] = like.errors.full_messages.join(' ')
    end
    redirect_to topic_path(topic)
  end
end
