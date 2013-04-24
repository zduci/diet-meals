class AddIndicesToFoodConnection < ActiveRecord::Migration
  def change
    add_index :food_connections, :parent_food_id
    add_index :food_connections, :child_food_id
  end
end
