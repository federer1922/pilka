class RemoveMatchesFromPlayers < ActiveRecord::Migration[6.0]
  def change
    remove_column :players, :match_id
  end
end
