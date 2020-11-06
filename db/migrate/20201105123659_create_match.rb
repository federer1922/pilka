class CreateMatch < ActiveRecord::Migration[6.0]
  def change
    create_table :matches do |t|
      t.string :team_1_name
      t.string :team_2_name
      t.string :match_result
      t.timestamps  
    end
  end
end
