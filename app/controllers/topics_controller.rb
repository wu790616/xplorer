class TopicsController < ApplicationController

  def index
    @hot_topics = Topic.all.order(followers_count: :desc).limit(5)
  end

  def show
    @base = Topic.find(params[:id])
    @center = Topic.find(params[:center].to_i)
    if(params[:page_num].to_i == 0)                # first X map
      @link1  = Topic.find(@center.topic_link1_id)
      @link2  = Topic.find(@center.topic_link2_id)
      @link3  = Topic.find(@center.topic_link3_id)
      @link4  = Topic.find(@center.topic_link4_id)
      @page   = 1
    else                                           # second X map
      @link1  = Topic.find(@center.topic_link5_id)
      @link2  = Topic.find(@center.topic_link6_id)
      @link3  = Topic.find(@center.topic_link7_id)
      @link4  = Topic.find(@center.topic_link8_id)
      @page   = 0
    end
    
    if((params[:from].to_i != 0)&(params[:from] != params[:center]))
      ahoy.track "XmapViewlog", {user: current_user, from: params[:from].to_i, to: params[:center].to_i, language: "Ruby"}
    end

    @logs = []
    viewlogs = Ahoy::Event.where(visit: current_visit, name: "XmapViewlog").order(id: :desc).limit(10)
    viewlogs.each do |log|
      @logs.push(Topic.find(log.properties["from"]))
    end
  end

end
