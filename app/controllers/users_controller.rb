class UsersController < ApplicationController
  expose(:users) { User.ordered }
  expose(:user) { User.includes(participants: :event, topics: :event).find(params[:id]) }

  before_filter :authenticate_current_user!, only: [:edit, :update]

  def index; end
  def show; end
  def edit; end

  def update
    if user.update_attributes params[:user]
      redirect_to :back, notice: t("user.saved_successful")
    else
      redirect_to :back, alert: user.errors.full_messages.join(' ')
    end
  end

  def destroy
    if current_user.events.present?
      redirect_to edit_user_path(current_user), alert: t("user.not_removed_organizer")
    else
      current_user.destroy
      redirect_to destroy_session_path, notice: t("user.removed")
    end
  end
end
