class MatchesController < ApplicationController

  def match_create 
    
    home_squad = Squad.new
    home_squad.team_name = params["home_team_name"]
    home_squad.save!
    
    away_squad = Squad.new
    away_squad.team_name = params["away_team_name"]
    away_squad.save!
    
    
    #match = Match.where(squad: squad).first
    #home_squad = Squad.find params["home_squad_id"]
    #away_squad = Squad.find params["away_squad_id"]
    match = Match.new
    match.home_squad = home_squad
    match.away_squad = away_squad
    match.match_result = params["match_result"]
    match.save!
            
    redirect_to action: "index", controller: "users"
  end
        
  def match_destroy
    match = Match.find params["match_id"]
    
    #match.players.destroy_all
    match.home_squad.players.destroy_all
    match.away_squad.players.destroy_all
    match.home_squad.destroy!
    match.away_squad.destroy! 
    match.destroy!
        
    redirect_to action: "index", controller: "users"
  end

  def show
    @match = Match.find params["match_id"]
    @home_squad = @match.home_squad 
    @away_squad = @match.away_squad
    @home_players = @home_squad.players.order(:created_at).to_a
    @away_players = @away_squad.players.order(:created_at).to_a
    #@players = @match.players
    #@other_users = User.all.to_a - @players.map { |player| player.user }
    @other_users = User.all.to_a - @home_players.map { |player| player.user } - @away_players.map { |player| player.user }

    #@team_1_players = Player.where(team_name: @match.team_1_name).order(:created_at).to_a
    #@team_2_players = Player.where(team_name: @match.team_2_name).order(:created_at).to_a
  end

  def add_goal_scored
    
    match = Match.find params["match_id"]
    player = Player.find params["player_id"]
    player.goals_scored = player.goals_scored + 1
    user = player.user
    user.goals_count = user.goals_count + 1
    user.save
    player.save

    redirect_to action: "show", match_id: match.id
  end

  def subtract_goal_scored
    match = Match.find params["match_id"]
    player = Player.find params["player_id"]
    player.goals_scored = player.goals_scored - 1
    if player.save
    user = player.user
    user.goals_count = user.goals_count - 1
    user.save
    else
      flash[:alert] = player.errors.full_messages.first 
    end

    redirect_to action: "show", match_id: match.id
  end
 
end