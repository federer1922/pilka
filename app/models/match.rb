class Match < ApplicationRecord

  has_many :players 
  has_many :users, through: :players
  belongs_to :home_squad, class_name: "Squad"
  belongs_to :away_squad, class_name: "Squad"
  
  def home_team_name
    if home_squad
      home_squad.team_name
    else
      team_1_name
    end
  end

  def away_team_name
    if away_squad
      away_squad.team_name
    else
      team_2_name
    end
  end
 
end
    