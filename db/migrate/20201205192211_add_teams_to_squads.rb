class AddTeamsToSquads < ActiveRecord::Migration[6.0]
  def change
    add_reference :squads, :team, index: true
  end
end
