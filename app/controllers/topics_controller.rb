class TopicsController < ApplicationController
  before_filter :check_login, only: [:new, :create]

  expose(:topic)
  expose(:topics_undone) { [] } # TODO

  def show; end

  def new; end

  def create
    topic.label = Whitelabel[:label_id]
    topic.user  = current_user
    if topic.save
      redirect_to(topic_path(topic), notice: t("flash.topic_added"))
    else
      redirect_to(new_topic_path, alert: topic.errors.full_messages.join(', '))
    end
  end
end
