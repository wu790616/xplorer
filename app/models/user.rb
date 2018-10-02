class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
  mount_uploader :avatar, AvatarUploader
  acts_as_taggable_on :skills

  # 驗證name不可空白
  validates :name, presence: true

  # 一個使用者有多篇Issue
  has_many :issues, dependent: :destroy

  # 一個使用者有多個關注Topic
  has_many :topic_followships, dependent: :destroy
  has_many :following_topics, through: :topic_followships, source: :topic

  # 一個使用者可以like多篇issue
  has_many :likes, dependent: :destroy
  has_many :liked_issues, through: :likes, source: :issue

  # 一個使用者可以收藏多篇issue
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_issues, through: :bookmarks, source: :issue

  # 一個使用者有多個Comment
  has_many :comments, dependent: :destroy
  has_many :commented_issues, through: :comments, source: :issue

  # 一個使用者有多個Reply
  has_many :replies, dependent: :destroy

  # 一個 User 擁有很多追蹤紀錄，透過追蹤紀錄，一個 User 追蹤很多其他 User (followings)
  has_many :user_followships, dependent: :destroy
  has_many :followings, through: :user_followships

  # 一個 User 擁有很多被追蹤紀錄，透過被追蹤紀錄，一個 User 被很多其他 User 追蹤 (followers)
  has_many :inverse_user_followships, class_name: "UserFollowship", foreign_key: "following_id"
  has_many :followers, through: :inverse_user_followships, source: :user

  # 通知
  has_many :notifications, as: :recipient#, dependent: :destroy

  # 檢查是否有追蹤紀錄
  def following?(user)
    self.followings.include?(user)
  end  
  def followingtopic?(topic)
    self.following_topics.include?(topic)
  end  

  # for fb omniauth
  def self.from_omniauth(auth)
    # Case 1: Find existing user by facebook uid
    user = User.find_by_fb_uid( auth.uid )
    if user
      user.fb_token = auth.credentials.token
      user.save!
      return user
    end

    # Case 2: Find existing user by email
    existing_user = User.find_by_email( auth.info.email )
    if existing_user
      existing_user.fb_uid = auth.uid
      existing_user.fb_token = auth.credentials.token
      existing_user.save!
      return existing_user
    end

    # Case 3: Create new password
    user = User.new
    user.fb_uid = auth.uid
    user.fb_token = auth.credentials.token
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
    user.name = auth.info.name
    user.remote_avatar_url = auth.info.image
    user.save!
    return user
  end

  # for google omniauth
  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    
    # Case 1: Find existing user by google uid
    user = User.find_by_google_uid( access_token.uid )
    if user
      return user
    end

    # Case 2: Find existing user by email
    existing_user = User.find_by_email( access_token.info.email )
    if existing_user   
      existing_user.google_uid = access_token.uid
      existing_user.google_token = access_token.credentials.token
      existing_user.save!
      return existing_user
    end

    # Case 3: Create new password
    user = User.new
    user.google_uid = access_token.uid 
    user.google_token = access_token.credentials.token
    user.email = data.email
    user.password = Devise.friendly_token[0,20]
    user.name = data.name
    user.remote_avatar_url = data.image
    user.save!
    return user    
  end
end
