class UsersController < ApplicationController
  before_action :authenticate_current_user!, only: [:edit, :update]
  before_action :check_peering, only: [:show]

  expose(:user)  { User.find params[:id] }
  expose(:users) { User.peers }

  def index; end
  def show; end
  def edit; end

  def update
    if current_user.update_attributes user_params
      redirect_to :back, notice: t("user.saved_successful")
    else
      redirect_to :back, alert: current_user.errors.full_messages.join(' ')
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
    params.require(:user).permit(:twitter, :github, :email, :name, :freelancer, :available, :hide_jobs, :participants, :image, :url)
  end

  def check_peering
    head 404 unless user.peer?
  end
end
