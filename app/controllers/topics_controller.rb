class TopicsController < ApplicationController

  def index
    if(current_user)
      @hot_topics = current_user.following_topics.order(topic_tagships_count: :desc).limit(5)
    else
      @hot_topics = Topic.all.order(topic_tagships_count: :desc).limit(5)
    end
    @issues = Issue.all.order(created_at: :desc).limit(5)
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
    
    @issues = @base.taged_issues

    if((params[:from].to_i != 0)&(params[:from] != params[:center]))
      ahoy.track "XmapViewlog", {from: params[:from].to_i, to: params[:center].to_i, progress: "init"}
    end

    if((current_user) && (params[:id] == params[:center]))
      ahoy.track "TopicEnterlog", {topic: params[:id].to_i, progress: "init"}
    end

    @logs = []
    if current_user
      viewlogs = Ahoy::Event.where(user: current_user, visit: current_visit, name: "XmapViewlog").order(id: :desc).limit(10)
    else
      viewlogs = Ahoy::Event.where(visit: current_visit, name: "XmapViewlog").order(id: :desc).limit(10)
    end
    viewlogs.each do |log|
      @logs.push(Topic.find(log.properties["from"]))
    end
  end

end
