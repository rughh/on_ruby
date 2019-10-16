# frozen_string_literal: true

class TopicsController < ApplicationController
  before_action :authenticate!, only: %i[new edit update create]
  before_action :validate_topic_ownership!, only: %i[edit update]

  expose(:topic, find: ->(id, scope) { scope.find_by_slug(id) })
  expose(:events)           { Event.with_topics.ordered.page(params[:page]) }
  expose(:undone_topics)    { Topic.ordered.undone }
  expose(:done_topics)      { Topic.ordered.done }
  expose(:upcoming_topics)  { Topic.ordered.upcoming }

  def index; end

  def show; end

  def new; end

  def edit; end

  def create
    topic.label = Whitelabel[:label_id]
    topic.user  = current_user
    topic.assign_attributes(topic_params)
    if topic.save
      if current_user.email.blank?
        redirect_to(edit_user_path(current_user), notice: t('flash.add_email'))
      else
        redirect_to(topic_path(topic), notice: t('flash.topic_added'))
      end
    else
      redirect_to(new_topic_path, alert: topic.errors.full_messages.join(', '))
    end
  end

  def update
    if topic.update(topic_params)
      redirect_to(topic_path(topic), notice: t('flash.topic_updated'))
    else
      redirect_to(edit_topic_path, alert: topic.errors.full_messages.join(', '))
    end
  end

  private

  def validate_topic_ownership!
    redirect_to(root_path, alert: t('flash.not_authenticated')) if topic.user != current_user && !current_user.admin?
  end

  def topic_params
    params.require(:topic).permit(:label, :name, :user, :description, :proposal_type)
  end
end
