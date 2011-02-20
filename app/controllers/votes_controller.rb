class VotesController < ApplicationController

  before_filter :check_login, :only => :create

  def create
    @wish = Wish.find params[:wish_id]
    @vote = Vote.new params[:vote]
    @vote.wish = @wish
    @vote.user = current_user
    if @wish.already_voted?(current_user)
      redirect_to(wishes_path, :alert => 'Du darfst nicht mehrfach bewerten!')
    elsif @vote.save
      redirect_to(wishes_path, :notice => 'Das Thema wurde bewertet.')
    else
      redirect_to(wishes_path, :alert => @vote.errors.full_messages.join(' '))
    end
  end

end
