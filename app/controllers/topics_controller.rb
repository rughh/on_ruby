# encoding: utf-8
class TopicsController < InheritedResources::Base
  load_and_authorize_resource

  belongs_to :event

  def create
    create! do |success, failure|
      success.html { redirect_to parent_url, :notice => 'Neues Thema erzeugt!' }
      failure.html { redirect_to parent_url, :alert => @topic.errors.full_messages.join(', ') }
    end
  end

  def destroy
    destroy!(:notice => 'Thema wurde gelöscht!') { parent_url }
  end
  
end
