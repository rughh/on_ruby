class UsersController < ApplicationController

  my_caches_action :show

  expose(:users) { User.ordered }
  expose(:user) { User.includes(participants: :event, topics: :event).find(params[:id]) }

  before_filter :authenticate_current_user!, only: [:edit, :update]

  def show; end

  def edit; end

  def update
    user.update_attributes! params[:user]
    redirect_to :back, notice: t("user.saved_successful")
  end
end
