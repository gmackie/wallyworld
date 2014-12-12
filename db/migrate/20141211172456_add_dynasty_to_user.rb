class AddDynastyToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.integer :wins
      t.integer :losses
      t.integer :active_dynasties
      t.integer :seasons_completed
      t.integer :access_level
      t.boolean :played_game
      t.integer :recruiting_points
      t.boolean :auto_pilot
    end
  end
end
