class TopicsController < ApplicationController
  before_action :validates_search_key, only: [:search]

  def intro
    @intro_topics = Topic.all.order(topic_tagships_count: :desc).limit(5)
  end
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
      status =  if current_user
                  if current_user.followingtopic?(topics[i])
                    10
                  else
                    4
                  end
                else
                  8
                end
      
      @map_topics.push({name: topics[i].name, base: topics[i].id, center: topics[i].id, from: topics[i].id, page: 0, strength: 200, status: status})
      
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
    @hot_topics = Topic.all.order(topic_tagships_count: :desc).limit(5)

    # URL analysis
    # topiics/base_id?center=center_id&from=from_id&page_num=page_num&scale=max_layer
    @base   = Topic.find(params[:id])
    from    = (params[:from].to_i == 0) ? @base : Topic.find(params[:from].to_i)
    @center = (params[:center].to_i == 0) ? @base : Topic.find(params[:center].to_i)
    @scale  =  params[:scale].to_i

    # Xplorer map
    xmap = @center.system_map(@base, from, params[:scale].to_i, params[:page_num].to_i, current_user)
    @topics = xmap[0][:topics]
    @links  = xmap[1][:links]

    # Topic issues
    @issues = @base.taged_issues.published.order(edit_time: :desc).page(params[:page]).per(15)

    # User activity
    if (params[:from].to_i != 0) && (params[:from] != params[:center])
      ahoy.track "XmapViewlog", {from: params[:from].to_i, to: params[:center].to_i, layer: @scale, progress: "init"}
    end

    if((current_user) && (params[:id] == params[:center]))
      ahoy.track "TopicEnterlog", {topic: params[:id].to_i, progress: "init"}
    end

    # Logs for display
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
    @issues = Issue.published.ransack({:title_or_content_cont => @search}).result(distinct: true).page(params[:search_issue_page]).per(10)
    @users = User.ransack({:name_cont => @search}).result(distinct: true)
  end

  protected

  # 將\, ', ? 去掉
  def validates_search_key
    @search = params[:search].gsub(/\\|\'|\/|\?/, "") if params[:search].present?
  end
end
