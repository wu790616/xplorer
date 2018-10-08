class IssuesController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :set_issue, only: [:show, :edit, :destroy, :update ]

  def new
    @issue = Issue.new
  end

  def create
    @issue = Issue.new(issue_params)
    @issue.user = current_user
    @issue.edit_time = Time.current
    if @issue.draft
      if @issue.save
        flash[:notice] = "草稿儲存成功"
        redirect_to issue_path(@issue)
      else
        render :new
      end
    else
      publish_issue
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
    @issue.edit_time = Time.current
    if @issue.update(issue_params)
      if @issue.draft
        flash[:notice] = "草稿儲存成功"
        redirect_to issue_path(@issue)
      else
        publish_issue
      end
    else
      render :edit
    end
  end

  private

  def issue_params
    params.require(:issue).permit(:title, :content, :draft, :edit_time, :topic_list, :taged_topic_ids => [])
  end

  def set_issue
    @issue = Issue.find(params[:id])
  end

  def publish_issue
    if @issue.title.empty? || @issue.content.empty? || @issue.taged_topics.empty?
      @issue.draft = true
      @issue.save
      flash[:alert] = "議題發佈時，標題、內容、標籤不可為空。"
      redirect_to edit_issue_path(@issue)
    else
      @issue.save
      flash[:notice] = "議題發佈成功"
      redirect_to issue_path(@issue)
    end
  end

end
