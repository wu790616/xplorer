class RepliesController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = Comment.find(params[:comment_id])
    @reply = @comment.replies.build(reply_params)
    @reply.user = current_user
    @reply.save!
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @reply = Reply.find(params[:id])
    @reply.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def reply_params
    params.require(:reply).permit(:content)
  end
end
