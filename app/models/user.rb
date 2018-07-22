class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # 如果 User 已經有了評論，就不允許刪除帳號（刪除時拋出 Error）
  has_many :comments, dependent: :restrict_with_error
  has_many :restaurants, through: :comments

  # 「使用者收藏很多餐廳」的多對多關聯
  has_many :favorites, dependent: :destroy
  has_many :favorited_restaurants, through: :favorites, source: :restaurant

  # 「使用者喜歡很多餐廳」的多對多關聯
  has_many :likes, dependent: :destroy
  has_many :liked_restaurants, through: :likes, source: :restaurant

  # 「使用者可以追蹤很多人」的多對多關聯
  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships

  # 設定follower
  has_many :inverse_followships, class_name: "Followship", foreign_key: "following_id"
  has_many :followers, through: :inverse_followships, source: :user

  # 設定friend關係
  has_many :friendships, dependent: :destroy
  has_many :friendings, through: :friendships

  # 設定inverse_friend關係(被加入朋友)
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friending_id"
  has_many :frienders, through: :inverse_friendships, source: :user

  mount_uploader :avatar, AvatarUploader

  def admin?
    self.role == "admin"
  end

  def following?(user)
    self.followings.include?(user)
  end
  
  def friending?(user)
    self.friendings.include?(user)
  end

  def all_friends 
    friends = self.friendings + self.frienders
    return friends.uniq
  end

end
