class User < ApplicationRecord

  has_many :players 
  has_many :squads, through: :players

  validates :username, presence: true
end


