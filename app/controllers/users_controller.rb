class UsersController < ApplicationController
   before_action :set_user, only: [:show, :edit, :update]

  def show
    @marked_issues = @user.bookmarked_issues
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
