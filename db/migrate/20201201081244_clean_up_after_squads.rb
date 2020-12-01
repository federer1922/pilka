class CleanUpAfterSquads < ActiveRecord::Migration[6.0]
  def change
    remove_column :players, :team_name
    remove_column :players, :match_id

    remove_column :matches, :team_1_name
    remove_column :matches, :team_2_name
  end
end
