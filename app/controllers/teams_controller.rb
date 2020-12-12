class TeamsController < ApplicationController
    
  def show

    @team = Team.find params["team_id"]
    #@squads = Squad.where(team_id: @team.id).order(:created_at).to_a
    @squads = Squad.joins(:team).where(teams: { id: @team.id })
    #@squad_ids = @squads.map { |squad| squad.id }

    #@home_matches = Match.where(home_squad_id: @squad_ids).order(:created_at).to_a
    @home_matches = Match.joins(:home_squad).where(squads: { team_id: @team.id }).to_a
    @away_matches = Match.joins(:away_squad).where(squads: {team_id: @team.id}).to_a
  end













end