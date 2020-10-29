class AddGoalsCountUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :goals_count, :integer  
  end
end
