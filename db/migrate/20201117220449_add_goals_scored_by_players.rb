class AddGoalsScoredByPlayers < ActiveRecord::Migration[6.0]
  def change
    add_column :players, :goals_scored, :integer
  end
end
