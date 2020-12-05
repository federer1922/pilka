class AddMatchesToPlayers < ActiveRecord::Migration[6.0]
  def change
    add_reference :players, :match, index: true
  end
end
