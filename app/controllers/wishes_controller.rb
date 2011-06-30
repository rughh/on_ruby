class WishesController < ApplicationController

  before_filter :check_login, :only => :create

  def index
    @wishes = Wish.order('CREATED_AT DESC').paginate :page => params[:page], :per_page => 10
    @wish = Wish.new
  end
  
  def show
    @wish = Wish.find params[:id]
  end

  def create
    @wish = Wish.new params[:wish]
    @wish.user = current_user
    @wish.votes << Vote.new do |v|
      v.user = current_user
      v.wish = @wish
      v.count = 5
    end
    if @wish.save
      @wish.publish(wishes_url)
      redirect_to(wishes_path, :notice => 'Dein Eintrag wurde gespeichert.')
    else
      redirect_to(wishes_path, :alert => @wish.errors.full_messages.join(' '))
    end
  end

end
