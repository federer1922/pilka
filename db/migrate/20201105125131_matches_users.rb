class MatchesUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :matches_users do |t|
      t.timestamps  
    end

    add_reference :matches_users, :matches, foreign_key: { to_table: :matches_users }, null: false
    add_reference :matches_users, :users, foreign_key: { to_table: :matches_users }, null: false
  end
end
