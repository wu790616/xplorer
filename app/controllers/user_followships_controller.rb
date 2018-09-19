class UserFollowshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @followship = current_user.user_followships.build(following_id: params[:following_id])

    if @followship.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @followship = current_user.user_followships.where(following_id: params[:id]).first
    @followship.destroy
    redirect_back(fallback_location: root_path)
  end
end
