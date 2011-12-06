class WishesController < ApplicationController

  before_filter :check_login, :only => :create

  expose(:wish)

  def show; end

  def create
    wish.user = current_user
    wish.votes << Vote.new do |v|
      v.user = current_user
      v.wish = wish
      v.count = 5
    end
    if wish.save
      redirect_to(root_path, :notice => 'Dein Eintrag wurde gespeichert.')
    else
      redirect_to(root_path, :alert => wish.errors.full_messages.join(' '))
    end
  end

end
