class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @like = current_user.likes.build(issue_id: params[:issue_id])
    @like.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @like = current_user.likes.where(issue_id: params[:id]).first
    @like.destroy
    redirect_back(fallback_location: root_path)
  end
end