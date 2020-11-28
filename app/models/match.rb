class Match < ApplicationRecord

  has_many :players 
  has_many :users, through: :players
  belongs_to :home_squad, class_name: "Squad"
  belongs_to :away_squad, class_name: "Squad"
 
end
    