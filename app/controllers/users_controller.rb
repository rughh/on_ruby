class UsersController < ApplicationController
  
  expose(:users) { User.order(:name).paginate(:page => params[:page], :per_page => 10) }
  expose(:user)
  
  def index; end
  
  def edit; end

  def update
    if user == current_user
      user.update_attributes! params[:user]
      redirect_to :back, :notice => 'Deine Daten wurden gespeichert.'
    else
      redirect_to :back, :alert => 'Hoppala, du darfst das nicht aktualisieren!'
    end
  end
end
