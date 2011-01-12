class WishesController < ApplicationController

  before_filter :check_login, :only => :create

  def index
    @wishes = Wish.paginate :page => params[:page], :per_page => 10
    @wish = Wish.new
  end

  def create
    @wish = Wish.new params[:wish]
    @wish.user = current_user
    if @wish.save
      redirect_to(wishes_path, :notice => 'Dein Eintrag wurde gespeichert.')
    else
      redirect_to(wishes_path, :alert => @wish.errors.full_messages.join(' '))
    end
  end

end
