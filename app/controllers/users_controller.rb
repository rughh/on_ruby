class UsersController < ApplicationController
  
  expose(:users) { User.order(:name) }
  expose(:user)
  
  before_filter :authenticate_current_user!, :only => [:edit, :update]
  
  def show; end

  def edit; end

  def update
    user.update_attributes! params[:user]
    redirect_to :back, :notice => 'Deine Daten wurden gespeichert.'
  end
end
