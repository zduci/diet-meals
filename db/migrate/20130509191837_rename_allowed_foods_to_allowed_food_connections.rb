class RenameAllowedFoodsToAllowedFoodConnections < ActiveRecord::Migration
  def change
    rename_table :allowed_foods, :allowed_food_connections
  end
end
