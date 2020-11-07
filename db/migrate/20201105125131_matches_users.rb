class MatchesUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :matches_users do |t|
      t.timestamps  
    end

    add_reference :matches_users, :match, foreign_key: { to_table: :matches }, null: false
    add_reference :matches_users, :user, foreign_key: { to_table: :users }, null: false
  end
end
