class UsersController < ApplicationController
   before_action :set_user, only: [:show, :edit, :update]

  def show
    @marked_issues = @user.bookmarked_issues
    @posted_issues = @user.issues.where( :draft => false ).order(edit_time: :desc)
    @unposted_issues = @user.issues.where( :draft => true ).order(edit_time: :desc)
    @commented_issues = @user.commented_issues.uniq
    @followers = @user.followers
    @followings = @user.followings
    @likes_total = @posted_issues.sum(:likes_count)
    @views_total = @posted_issues.sum(:views_count)
  end

  def edit
    if @user != current_user
      redirect_to user_path(@user)
    end
  end

  def update
    @user.update(user_params)
    redirect_to user_path(@user)
  end
  
  private

  def set_user
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:name, :introduction, :avatar, :contact_privacy, :topic_follow_privacy, :issue_book_privacy, :skill_list)
  end
end
