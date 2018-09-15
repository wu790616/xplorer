class IssuesController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :set_issue, only: [:show, :edit, :destroy, :update, :taglist, :publish]
  before_action :set_topic_issue, only: [:tag, :untag]

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
    if @issue.draft==true && @issue.user!=current_user
      redirect_to root_path
    end
    @comment = Comment.new
    @comments = @issue.comments
    @reply = Reply.new
  end

  def edit
  end

  def destroy
    @issue.destroy
    redirect_to root_path
  end

  def update
    if @issue.update(issue_params)
      if @issue.draft
        redirect_to issue_path(@issue)
      else
        @issue.draft = true
        @issue.save
        redirect_to taglist_issue_path(@issue)
      end
    else
      render :edit
    end
  end

  # 列出所有topic清單
  def taglist
    @topics = Topic.all
  end

  # Issue tag 該 topic
  def tag
    @issue.topic_tagships.create!(topic: @topic)
    redirect_back(fallback_location: root_path)
  end

  # Issue untag 該 topic
  def untag
    topic_tagships = TopicTagship.where(topic: @topic, issue: @issue)
    topic_tagships.destroy_all
    redirect_back(fallback_location: root_path)
  end

  # 將issue的draft改成false
  def publish
    if @issue.title.empty? or @issue.content.empty? 
      redirect_to edit_issue_path(@issue)
    else
      @issue.draft = false
      @issue.save
      redirect_to issue_path(@issue)
    end
  end

  private

  def issue_params
    params.require(:issue).permit(:title, :content, :draft)
  end

  def set_issue
    @issue = Issue.find(params[:id])
  end

  def set_topic_issue
    @topic = Topic.find(params[:topic])
    @issue = Issue.find(params[:issue])
  end

end
