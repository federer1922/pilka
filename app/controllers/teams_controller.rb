class TeamsController < ApplicationController
    
  def show

    @team = Team.find params["team_id"]
    @squads = Squad.where(team_id: @team.id).order(:created_at).to_a
    @squad_ids = @squads.map { |squad| squad.id }

    @home_matches = Match.where(home_squad_id: @squad_ids).order(:created_at).to_a
    @away_matches = Match.where(away_squad_id: @squad_ids).order(:created_at).to_a
    
    #@home_squad = @match.home_squad 
    #@away_squad = @match.away_squad
    #@home_players = @home_squad.players.order(:created_at).to_a
    #@away_players = @away_squad.players.order(:created_at).to_a
  end













end