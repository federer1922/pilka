class Team < ApplicationRecord  
  has_many :squads   

  validates :name, presence: true
end