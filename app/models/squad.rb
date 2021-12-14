class Squad < ApplicationRecord
  has_many :players 
  has_one :home_match, :class_name => "Match", :foreign_key => "home_squad_id"
  has_one :away_match, :class_name => "Match", :foreign_key => "away_squad_id"
  has_many :users, through: :players
  belongs_to :team

  validates :team_name, presence: true
end