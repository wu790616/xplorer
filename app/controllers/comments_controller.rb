class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @issue = Issue.find(params[:issue_id])
    @comment = @issue.comments.build(comment_params)
    @comment.user = current_user
    @comment.save!
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
