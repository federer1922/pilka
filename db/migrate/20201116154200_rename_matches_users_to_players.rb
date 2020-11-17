class RenameMatchesUsersToPlayers < ActiveRecord::Migration[6.0]
  def change
    rename_table :matches_users, :players
  end
end
