class Admin::TopicsController < Admin::BaseAdminController
  def add_to_latest_event
    topic = Topic.find(params[:id])
    topic.event = Event.current.first
    topic.save!
    redirect_to url_for(controller: "/admin/topics", action: :edit, id: topic.id), notice: "Added to latest Event!"
  end
end
