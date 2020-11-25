class CreateSquads < ActiveRecord::Migration[6.0]
  def change
    create_table :squads do |t|
      t.string :team_name
      t.timestamps 
    end
  end
end
