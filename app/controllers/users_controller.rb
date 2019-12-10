# frozen_string_literal: true

class UsersController < ApplicationController
  include IcalHelper
  before_action :authenticate_current_user!, only: %i[edit update]

  expose(:user, find: ->(id, scope) { scope.find_by_slug(id) })

  expose(:users) { User.peers.page(params[:page]).per(3 * 10) }

  def index; end

  def show; end

  def edit; end

  def calendar
    respond_to do |format|
      format.ics do
        render plain: icalendar(*user.participations)
      end
    end
  end

  def update
    if current_user.update user_params
      redirect_back(notice: t('user.saved_successful'), fallback_location: root_url)
    else
      redirect_back(alert: current_user.errors.full_messages.join(' '), fallback_location: root_url)
    end
  end

  def destroy
    if current_user.events.present?
      redirect_to edit_user_path(current_user), alert: t('user.not_removed_organizer')
    else
      current_user.destroy
      redirect_to destroy_session_path, notice: t('user.removed')
    end
  end

  private

  def user_params
    params.require(:user).permit(:twitter, :github, :linkedin, :email, :name, :description, :freelancer, :available, :hide_jobs, :participants, :image, :url)
  end
end
