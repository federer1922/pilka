class AddMatchCountToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :match_count, :integer
  end
end
