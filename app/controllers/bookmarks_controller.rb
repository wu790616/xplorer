class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def create
    @bookmark = current_user.bookmarks.build(issue_id: params[:issue_id])
    @bookmark.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @bookmark = current_user.bookmarks.where(issue_id: params[:id]).first
    @bookmark.destroy
    redirect_back(fallback_location: root_path)
  end
end
