class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant, counter_cache: :favorites_count
end
