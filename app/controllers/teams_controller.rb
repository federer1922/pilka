class TeamsController < ApplicationController
    
  def show

    @team = Team.find params["team_id"]
    @home_matches = Match.joins(:home_squad).where(squads: { team_id: @team.id }).to_a
    @away_matches = Match.joins(:away_squad).where(squads: { team_id: @team.id}).to_a
  end
end