class Followship < ApplicationRecord
  belongs_to :user
  belongs_to :folowing, class_name: "User" 
end
