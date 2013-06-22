class LikesController < ApplicationController
  before_action :authenticate!

  respond_to :html

  expose(:topic)
  expose(:like)

  def create
    like.topic = topic
    like.user = current_user
    if topic.already_liked?(current_user)
      redirect_to(topic_path(topic), alert: t("flash.double_like"))
    elsif like.save
      redirect_to(topic_path(topic), notice: t("flash.liked"))
    else
      redirect_to(topic_path(topic), alert: like.errors.full_messages.join(' '))
    end
  end

  def destroy
    if topic.already_liked?(current_user) && like.destroy
      redirect_to(topic_path(topic), notice: t("flash.unliked"))
    else
      redirect_to(topic_path(topic), alert: like.errors.full_messages.join(' '))
    end
  end
end
