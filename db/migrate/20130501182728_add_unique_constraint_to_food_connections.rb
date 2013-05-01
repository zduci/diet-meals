class AddUniqueConstraintToFoodConnections < ActiveRecord::Migration
  def change
    add_index :food_connections, [:parent_food_id, :child_food_id], :unique => true
  end
end
