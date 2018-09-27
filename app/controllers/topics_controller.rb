class TopicsController < ApplicationController
  before_action :validates_search_key, only: [:search]

  def fullmap
    topics = []
    topics.push(Topic.where(name: "電腦").first)
    topics.push(Topic.where(name: "AI" ).first)
    topics.push(Topic.where(name: "大數據" ).first)
    topics.push(Topic.where(name: "藝術" ).first)
    topics.push(Topic.where(name: "生活" ).first)
    topics.push(Topic.where(name: "心理" ).first)
    topics.push(Topic.where(name: "科學" ).first)
    topics.push(Topic.where(name: "數學" ).first)
    topics.push(Topic.where(name: "區塊鏈" ).first)
    topics.push(Topic.where(name: "生物學" ).first)
    topics.push(Topic.where(name: "化學" ).first)
    topics.push(Topic.where(name: "物理" ).first)
    topics.push(Topic.where(name: "語言" ).first)
    topics.push(Topic.where(name: "文學" ).first)
    topics.push(Topic.where(name: "行銷" ).first)
    topics.push(Topic.where(name: "經濟" ).first)
    topics.push(Topic.where(name: "市場" ).first)
    topics.push(Topic.where(name: "設計" ).first)
    topics.push(Topic.where(name: "運動學" ).first)
    topics.push(Topic.where(name: "藝術" ).first)

    @map_topics = []
    @map_links = []
    topics.count.times do |i|
      if current_user
        if current_user.followingtopic?(topics[i])
          @map_topics.push({name: topics[i].name, base: topics[i].id, center: topics[i].id, from: topics[i].id, page: 0, strength: 200, status: 10})
        else
          @map_topics.push({name: topics[i].name, base: topics[i].id, center: topics[i].id, from: topics[i].id, page: 0, strength: 200, status: 4})
        end
      else
        @map_topics.push({name: topics[i].name, base: topics[i].id, center: topics[i].id, from: topics[i].id, page: 0, strength: 200, status: 8})
      end
      topics.count.times do |j|
        link = XplorerMap.where(from_id: topics[i].id, to_id: topics[j].id).first
        if(link == nil)
        else
          @map_links.push({source: i, target:j, strength: -200})
        end
      end
    end

  # # Full map
  # file = File.read('public/fixed_topic.json')
  # @map_topics = JSON.parse(file)
  # file = File.read('public/fixed_link.json')
  # @map_links = JSON.parse(file)
  end

  def index
    # hot topics
    if(current_user && (current_user.following_topics.first != nil))
      @hot_topics = current_user.following_topics.order(topic_tagships_count: :desc).limit(5)
    else
      @hot_topics = Topic.all.order(topic_tagships_count: :desc).limit(5)
    end
    # issue
    @hot_issues = Issue.published.order(views_count: :desc).page(params[:hot_issues_page]).per(10)
    @hot_users = User.order(followers_count: :desc).limit(10)
    hot_user_ids = Array.new
    @hot_users.each do |user|
      hot_user_ids.push(user.id)
    end
    @hot_users_issues = Issue.published.where(:user => hot_user_ids).order(edit_time: :desc).page(params[:hot_users_issues_page]).per(10)
    if(current_user)
      @user_followings = current_user.followings
      @followings_issues = Issue.published.where(:user => @user_followings).order(edit_time: :desc).page(params[:followings_issues_page]).per(10)
      @topic_followings = current_user.following_topics
      @tagships = TopicTagship.where(:topic => @topic_followings)
      @topic_followings_issues = Issue.published.where(:topic_tagships => @tagships).order(edit_time: :desc).page(params[:topic_followings_issues_page]).per(10)
    end
  end

  def show
    @base = Topic.find(params[:id])
    @center = (params[:center].to_i == 0) ? @base : Topic.find(params[:center].to_i)
    if(params[:page_num].to_i == 0)                # first X map
      @link1  = (@center.topic_link1_id == nil) ? nil : Topic.find(@center.topic_link1_id)
      @link2  = (@center.topic_link2_id == nil) ? nil : Topic.find(@center.topic_link2_id)
      @link3  = (@center.topic_link3_id == nil) ? nil : Topic.find(@center.topic_link3_id)
      @link4  = (@center.topic_link4_id == nil) ? nil : Topic.find(@center.topic_link4_id)
      @page   = 1
    else                                           # second X map
      @link1  = (@center.topic_link5_id == nil) ? nil : Topic.find(@center.topic_link5_id)
      @link2  = (@center.topic_link6_id == nil) ? nil : Topic.find(@center.topic_link6_id)
      @link3  = (@center.topic_link7_id == nil) ? nil : Topic.find(@center.topic_link7_id)
      @link4  = (@center.topic_link8_id == nil) ? nil : Topic.find(@center.topic_link8_id)
      @page   = 0
    end
    
    # JSON for Xmap
    @topics = []
    @topics.push({name: "#{@center.name}", base: "#{@center.id}", center: "#{@center.id}", from: @center.id, page: @page ,strength: 2000})
    @topics.push({name: "#{@link1.name }", base: "#{@base.id}"  , center: "#{@link1.id }", from: @center.id, page: 0     ,strength: 1000}) unless (@link1 == nil)
    @topics.push({name: "#{@link2.name }", base: "#{@base.id}"  , center: "#{@link2.id }", from: @center.id, page: 0     ,strength: 1000}) unless (@link2 == nil)
    @topics.push({name: "#{@link3.name }", base: "#{@base.id}"  , center: "#{@link3.id }", from: @center.id, page: 0     ,strength: 1000}) unless (@link3 == nil)
    @topics.push({name: "#{@link4.name }", base: "#{@base.id}"  , center: "#{@link4.id }", from: @center.id, page: 0     ,strength: 1000}) unless (@link4 == nil)
    @topics.push({name: "Re-generate"    , base: "#{@base.id}"  , center: "#{@center.id}", from: @center.id, page: @page ,strength: 2000}) unless (@center.links_count <= 4)

    @links = []
    @links.push({source: 0, target:1, strength: XplorerMap.where(from_id: @center.id, to_id: @link1.id).first.strength}) unless (@link1 == nil)
    @links.push({source: 0, target:2, strength: XplorerMap.where(from_id: @center.id, to_id: @link2.id).first.strength}) unless (@link2 == nil)
    @links.push({source: 0, target:3, strength: XplorerMap.where(from_id: @center.id, to_id: @link3.id).first.strength}) unless (@link3 == nil)
    @links.push({source: 0, target:4, strength: XplorerMap.where(from_id: @center.id, to_id: @link4.id).first.strength}) unless (@link4 == nil)

    @issues = @base.taged_issues.published.order(edit_time: :desc).page(params[:page]).per(15)

    if((params[:from].to_i != 0)&(params[:from] != params[:center]))
      ahoy.track "XmapViewlog", {from: params[:from].to_i, to: params[:center].to_i, progress: "init"}
    end

    if((current_user) && (params[:id] == params[:center]))
      ahoy.track "TopicEnterlog", {topic: params[:id].to_i, progress: "init"}
    end

    @logs = []
    if current_user
      viewlogs = Ahoy::Event.where(user: current_user, visit: current_visit, name: "XmapViewlog").order(id: :desc).limit(12)
    else
      viewlogs = Ahoy::Event.where(visit: current_visit, name: "XmapViewlog").order(id: :desc).limit(12)
    end
    viewlogs.each do |log|
      @logs.push(Topic.find(log.properties["from"]))
    end
  end

  def search
    @topics = Topic.ransack({:name_cont => @search}).result(distinct: true)
    @issues = Issue.published.ransack({:title_or_content_cont => @search}).result(distinct: true)
    @users = User.ransack({:name_cont => @search}).result(distinct: true)
  end

  protected

  # 將\, ', ? 去掉
  def validates_search_key
    @search = params[:search].gsub(/\\|\'|\/|\?/, "") if params[:search].present?
  end
end
