class PreController < ApplicationController
  
  def index
    @users = User.all
    render :layout => false
  end
end
