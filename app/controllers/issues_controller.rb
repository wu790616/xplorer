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
        redirect_to issue_path(@issue)
      else
        render :new
      end
    else
      if @issue.title.empty? or @issue.content.empty? or @issue.taged_topics.empty?
        @issue.draft = true
        @issue.save
        redirect_to edit_issue_path(@issue)
      else
        @issue.save
        redirect_to issue_path(@issue)
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
    @issue.edit_time = Time.current
    if @issue.update(issue_params)
      if @issue.draft
        redirect_to issue_path(@issue)
      else
        if @issue.title.empty? or @issue.content.empty? or @issue.taged_topics.empty?
          @issue.draft = true
          @issue.save
          redirect_to edit_issue_path(@issue)
        else
          @issue.save
          redirect_to issue_path(@issue)
        end
      end
    else
      render :edit
    end
  end

  private

  def issue_params
    params.require(:issue).permit(:title, :content, :draft, :edit_time, :taged_topic_ids => [])
  end

  def set_issue
    @issue = Issue.find(params[:id])
  end

end
