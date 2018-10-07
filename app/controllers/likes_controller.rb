class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @like = current_user.likes.build(issue_id: params[:issue_id])
    @like.save

    respond_to do |format|
      format.js { render "issues/button" }
    end
  end

  def destroy
    @like = current_user.likes.where(issue_id: params[:id]).first
    @like.destroy
    
    respond_to do |format|
      format.js { render "issues/button" }
    end
  end
end