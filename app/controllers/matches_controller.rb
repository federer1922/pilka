class MatchesController < ApplicationController

  def match_create 
    
    home_squad = Squad.new
    home_squad.team_name = params["home_team_name"]
    if team = Team.where(name: home_squad.team_name).first
      home_squad.team = team
      home_squad.save!
    else
      team = Team.new
      team.name = home_squad.team_name
      team.save!
      home_squad.team = team
      home_squad.save!
    end
    
    away_squad = Squad.new
    away_squad.team_name = params["away_team_name"]
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
    match.match_result = params["match_result"]
    if match.save        
      redirect_to action: "index", controller: "users"
    else
      flash[:alert] = match.errors.full_messages.first
      redirect_to action: "index", controller: "users"
    end
  end
        
  def match_destroy

    match = Match.find params["match_id"]

    match.home_squad.players.each do |player|
      user = player.user
      user.match_count = user.match_count - 1
      user.goals_count = user.goals_count - player.goals_scored
      user.save!
    end
    match.away_squad.players.each do |player|
      user = player.user
      user.match_count = user.match_count - 1
      user.goals_count = user.goals_count - player.goals_scored
      user.save!
    end

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
    @other_users = User.all.to_a - @home_players.map { |player| player.user } - @away_players.map { |player| player.user }
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