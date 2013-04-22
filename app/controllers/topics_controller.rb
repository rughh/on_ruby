class TopicsController < ApplicationController
  before_filter :check_login, only: [:new, :create, :edit, :update]

  expose(:topic)
  expose(:events) { Event.with_topics.ordered.page(params[:page]).per(10) }
  expose(:undone_topics) { Topic.ordered.undone }
  expose(:done_topics) { Topic.ordered.done }

  def show; end
  def new; end
  def edit; end

  def create
    topic.label = Whitelabel[:label_id]
    topic.user  = current_user
    if topic.save
      redirect_to(topic_path(topic), notice: t("flash.topic_added"))
    else
      redirect_to(new_topic_path, alert: topic.errors.full_messages.join(', '))
    end
  end

  def update
    if topic.user == current_user
      if topic.save
        redirect_to(topic_path(topic), notice: t("flash.topic_updated"))
      else
        redirect_to(edit_topic_path, alert: topic.errors.full_messages.join(', '))
      end
    end
  end
end
