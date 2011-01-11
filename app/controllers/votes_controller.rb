class VotesController < ApplicationController

  def create
    @wish = Wish.find params[:wish_id]
    @vote = Vote.new params[:vote]
    @vote.wish = @wish
    @vote.user = current_user
    if current_user.nil?
      redirect_to(wishes_path, :alert => 'Du musst angemeldet sein!')
    elsif @wish.already_voted?(current_user)
      redirect_to(wishes_path, :alert => 'Du darfst nicht mehrfach bewerten!')
    elsif @wish.user == current_user
      redirect_to(wishes_path, :alert => 'Du darfst deinen Eigenen Wunsch nicht bewerten!')
    elsif @vote.save
      redirect_to(wishes_path, :notice => 'Das Thema wurde bewertet.')
    else
      redirect_to(wishes_path, :alert => @vote.errors.full_messages.join(' '))
    end
  end

end
