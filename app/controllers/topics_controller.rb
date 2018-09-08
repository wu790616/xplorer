class TopicsController < ApplicationController

  def index
    @hot_topics = Topic.all.order(followers_count: :desc).limit(5)
  end

  def show
    @center = Topic.find(params[:id])
    if(params[:page_num].to_i == 1)                # first X map
      @link1  = Topic.find(@center.topic_link1_id)
      @link2  = Topic.find(@center.topic_link2_id)
      @link3  = Topic.find(@center.topic_link3_id)
      @link4  = Topic.find(@center.topic_link4_id)
    else                                           # second X map
      @link1  = Topic.find(@center.topic_link5_id)
      @link2  = Topic.find(@center.topic_link6_id)
      @link3  = Topic.find(@center.topic_link7_id)
      @link4  = Topic.find(@center.topic_link8_id)
    end
  end
  
end
