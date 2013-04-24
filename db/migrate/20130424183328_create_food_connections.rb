class CreateFoodConnections < ActiveRecord::Migration
  def change
    create_table :food_connections do |t|
      t.integer :parent_food, :null => false
      t.integer :child_food, :null => false

      t.timestamps
    end
  end
end
