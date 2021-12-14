class Match < ApplicationRecord
  belongs_to :home_squad, class_name: "Squad"
  belongs_to :away_squad, class_name: "Squad"
  
  validates :match_result, presence: true
end
    