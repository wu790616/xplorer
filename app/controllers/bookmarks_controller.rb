class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def create
    @bookmark = current_user.bookmarks.build(issue_id: params[:issue_id])
    @bookmark.save

    respond_to do |format|
      format.js { render "issues/button" }
    end
  end

  def destroy
    @bookmark = current_user.bookmarks.where(issue_id: params[:id]).first
    @bookmark.destroy
    
    respond_to do |format|
      format.js { render "issues/button" }
    end
  end
end
