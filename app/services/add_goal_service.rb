module AddGoalService
  def self.call(id)
    player = Player.find id
    player.goals_scored = player.goals_scored + 1
    user = player.user
    user.goals_count = user.goals_count + 1
    user.save
    player.save
  end
end