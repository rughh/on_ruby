class VotesController < ApplicationController

  before_filter :check_login, :only => :create

  expose(:wish)
  expose(:vote)

  def create
    vote.wish = wish
    vote.user = current_user
    if wish.already_voted?(current_user)
      redirect_to(root_path, :alert => 'Du darfst nicht mehrfach bewerten!')
    elsif vote.save
      redirect_to(root_path, :notice => 'Das Thema wurde bewertet.')
    else
      redirect_to(root_path, :alert => vote.errors.full_messages.join(' '))
    end
  end

end
