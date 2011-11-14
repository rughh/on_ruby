class UsersController < ApplicationController

  expose(:users) { User.order(:name) }
  expose(:user)

  before_filter :authenticate_current_user!, :only => [:edit, :update]

  def index
    respond_to do |format|
      format.json { render_for_api :ios, :json => users }
      format.xml { render :text => 'bla' }
    end
  end

  def show; end

  def edit; end

  def update
    user.update_attributes! params[:user]
    redirect_to :back, :notice => 'Deine Daten wurden gespeichert.'
  end
end
