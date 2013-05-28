class RenameRecipeIdToMealId < ActiveRecord::Migration
  def change
    rename_column :ingredients, :recipe_id, :meal_id
  end
end
