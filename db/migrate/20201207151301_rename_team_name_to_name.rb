class RenameTeamNameToName < ActiveRecord::Migration[6.0]
  def change
    rename_column :teams, :team_name, :name
  end
end
