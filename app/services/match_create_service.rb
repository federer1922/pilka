module MatchCreateService
  def self.call(home_team_name, away_team_name, home_score, away_score)
    alert = nil
    if home_team_name.blank?
      alert = "Home team name can't be blank"
    elsif away_team_name.blank?
      alert = "Away team name can't be blank"
    else
      home_squad = Squad.new
      home_squad.team_name = home_team_name
      if team = Team.where(name: home_squad.team_name).first
        home_squad.team = team
        home_squad.save!
      else
        team = Team.new
        team.name = home_squad.team_name
        team.save
        home_squad.team = team
        home_squad.save!
      end 
      away_squad = Squad.new
      away_squad.team_name = away_team_name
      if team = Team.where(name: away_squad.team_name).first
        away_squad.team = team
        away_squad.save!
      else
        team = Team.new
        team.name = away_squad.team_name
        team.save!
        away_squad.team = team
        away_squad.save!
      end  
      match = Match.new
      match.home_squad = home_squad
      match.away_squad = away_squad
      if home_score.blank?
        alert = "Home team score can't be blank"
      elsif away_score.blank?
        alert = "Away team score can't be blank"
      else
        match.match_result = "#{ home_score.to_i }:#{ away_score.to_i }"
        match.save        
      end
    end
    alert
  end
end