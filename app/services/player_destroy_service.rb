module PlayerDestroyService
  def self.call(id)
    player = Player.find id
    user = player.user
    user.match_count = user.match_count - 1
    user.goals_count = user.goals_count - player.goals_scored
    user.save!
    player.destroy!
  end
end