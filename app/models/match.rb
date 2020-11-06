class Match < ApplicationRecord

  has_many :matches_users 
  has_many :users, through: :matches_users
      
end
    