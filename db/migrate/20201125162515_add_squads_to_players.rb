class AddSquadsToPlayers < ActiveRecord::Migration[6.0]
  def change
    add_reference :players, :squad, index: true
  end
end
