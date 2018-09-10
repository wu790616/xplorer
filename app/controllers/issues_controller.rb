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
        redirect_to root_path
      else
        render :new
      end
    end
  end

  private

  def issue_params
    params.require(:issue).permit(:title, :content, :draft)
  end

end
