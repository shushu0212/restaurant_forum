class Followship < ApplicationRecord
  belongs_to :user
  belongs_to :following, class_name: "User" 

  # 「每個 User 只能追蹤另一個 User 一次」，從資料表的角度來描述，就是「特定的 user_id 下，只能有一個 followings_id」
  validates :following_id, uniqueness: { scope: :user_id }
end
