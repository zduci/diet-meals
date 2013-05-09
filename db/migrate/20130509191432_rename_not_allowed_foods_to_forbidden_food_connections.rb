class RenameNotAllowedFoodsToForbiddenFoodConnections < ActiveRecord::Migration
  def change
    rename_table :not_allowed_foods, :forbidden_food_connections
  end
end
