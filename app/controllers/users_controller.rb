class UsersController < ApplicationController
   before_action :set_user, only: [:show, :edit, :update]

  def show
    @marked_issues = @user.bookmarked_issues.page(params[:marked_issues_page]).per(10)
    @posted_issues = @user.issues.where( :draft => false ).order(edit_time: :desc).page(params[:posted_issues_page]).per(10)
    @unposted_issues = @user.issues.where( :draft => true ).order(edit_time: :desc).page(params[:unposted_issues_page]).per(10)
    @commented_issues = @user.commented_issues.uniq
    @commented_issues_results = Kaminari.paginate_array(@commented_issues).page(params[:commented_issues_page]).per(10)
    @followers = @user.followers.page(params[:followers_page]).per(10)
    @followings = @user.followings
    @likes_total = @posted_issues.sum(:likes_count)
    @views_total = @posted_issues.sum(:views_count)
    @shares_total = @posted_issues.sum(:shares_count)
    @bookmarks_total = @posted_issues.sum(:bookmarks_count)

    # Personal map
    following_topics = @user.following_topics
    @map_topics = []
    @map_links = []
    following_topics.count.times do |i|
      @map_topics.push({name: following_topics[i].name, base: following_topics[i].id, center: following_topics[i].id, from: following_topics[i].id, page: 0, strength: @user.topic_followships.where(topic: following_topics[i]).first.strength})
      following_topics.count.times do |j|
        link = XplorerMap.where(from_id: following_topics[i].id, to_id: following_topics[j].id).first
        if(link == nil)
        else
          @map_links.push({source: i, target:j, strength: link.strength})
        end
      end
    end
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
