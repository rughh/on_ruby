class WishesController < ApplicationController
  before_filter :check_login, only: [:new, :create]

  expose(:wish)
  expose(:wishes_undone) { Wish.by_status(:undone) }

  def show; end

  def new; end

  def create
    wish.user = current_user
    wish.votes << Vote.new do |v|
      v.user = current_user
      v.wish = wish
      v.count = 5
    end
    if wish.save
      redirect_to(wish_path(wish), notice: t("flash.wish_added"))
    else
      redirect_to(new_wish_path, alert: wish.errors.full_messages.join(', '))
    end
  end
end
