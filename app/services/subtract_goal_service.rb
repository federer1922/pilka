module SubtractGoalService
  def self.call(id)
    alert = nil
    player = Player.find id
    player.goals_scored = player.goals_scored - 1
    if player.save
      user = player.user
      user.goals_count = user.goals_count - 1
      user.save
    else
      alert = player.errors.full_messages.first 
    end
    alert
  end
end