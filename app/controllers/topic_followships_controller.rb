class TopicFollowshipsController < ApplicationController
  before_action :authenticate_user!
  INIT_STRENGTH = 200
  
  def create  
    @followship = current_user.topic_followships.build(topic_id: params[:topic_id])
    @followship.strength = 200
    @followship.progress = "processed"

    unless @followship.save
      redirect_back(fallback_location: root_path)
    end

    respond_to do |format|
      format.js { render "topics/follow" }
    end
  end

  def destroy
    @followship = current_user.topic_followships.where(topic_id: params[:id]).first
    @followship.destroy
    
    respond_to do |format|
      format.js { render "topics/follow" }
    end
  end
end
