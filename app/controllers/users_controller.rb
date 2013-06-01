class UsersController < ApplicationController
  before_action :authenticate_current_user!, only: [:edit, :update]

  expose(:user, attributes: :user_params)
  expose(:users) { User.peers }

  def index; end
  def show; end
  def edit; end

  def update
    if user.save
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

  private

  def user_params
    params.require(:user).permit(:twitter, :github, :name, :freelancer, :available, :hide_jobs, :participants, :image, :url)
  end
end
