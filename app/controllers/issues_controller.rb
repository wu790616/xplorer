class IssuesController < ApplicationController
  before_action :authenticate_user!, except: :show

  def new
    @issue = Issue.new
  end

  def create
    @issue = Issue.new(issue_params)
    @issue.user = current_user
    if @issue.draft
      if @issue.save
        redirect_to root_path
      else
        render :new
      end
    else
      @issue.draft = true
      if @issue.save
        redirect_to taglist_issue_path(@issue)
      else
        render :new
      end
    end
  end

  def show
    @issue = Issue.find(params[:id])
  end

  # 列出所有topic清單
  def taglist
    @issue = Issue.find(params[:id])
    @topics = Topic.all
  end

  # Issue tag 該 topic
  def tag
    @topic = Topic.find(params[:topic])
    @issue = Issue.find(params[:issue])
    @issue.topic_tagships.create!(topic: @topic)
    redirect_back(fallback_location: root_path)
  end

  # Issue untag 該 topic
  def untag
    @topic = Topic.find(params[:topic])
    @issue = Issue.find(params[:issue])
    topic_tagships = TopicTagship.where(topic: @topic, issue: @issue)
    topic_tagships.destroy_all
    redirect_back(fallback_location: root_path)
  end

  # 將issue的draft改成false
  def publish
    @issue = Issue.find(params[:id])
    @issue.draft = false
    @issue.save
    redirect_to issue_path(@issue)
  end

  private

  def issue_params
    params.require(:issue).permit(:title, :content, :draft)
  end

end
