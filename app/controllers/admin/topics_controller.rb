class Admin::TopicsController < Admin::ApplicationController
  def add_to_next_event
    @topic = Topic.find_by_slug(params[:id])
    @user  = @topic.user

    if @event = Event.current.first
      @topic.event = @event
      @event.particpate(@user)
      @topic.save!
      redirect_to url_for(controller: '/admin/topics', action: :edit, id: @topic.id), notice: 'Added to latest Event!'
    else
      redirect_to(url_for(controller: '/admin/topics', action: :index), alert: 'no next event found')
    end
  end
end
