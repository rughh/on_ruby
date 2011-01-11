class WishesController < ApplicationController

  def index
    @wishes = Wish.paginate :page => params[:page], :per_page => 10
    @wish = Wish.new
  end

  def create
    @wish = Wish.new params[:wish]
    @wish.user = current_user
    if current_user.nil?
      redirect_to(wishes_path, :alert => 'Du musst angemeldet sein!')
    elsif @wish.save
      redirect_to(wishes_path, :notice => 'Dein Eintrag wurde gespeichert.')
    else
      redirect_to(wishes_path, :alert => @wish.errors.full_messages.join(' '))
    end
  end

end
