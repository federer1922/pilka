class Squad < ApplicationRecord
  has_many :players 
  has_many :matches
  has_many :users, through: :players
  
end