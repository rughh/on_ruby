class UsersController < ApplicationController
  def index
    @users = User.paginate :page => params[:page], :per_page => 10
  end
  
  def edit
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    if @user == current_user
      @user.update_attributes! params[:user]
      redirect_to :back, :notice => 'Deine Daten wurden gespeichert.'
    else
      redirect_to :back, :alert => 'Hoppala, du darfst das nicht aktualisieren!'
    end
  end
end
