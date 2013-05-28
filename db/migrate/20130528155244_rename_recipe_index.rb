class RenameRecipeIndex < ActiveRecord::Migration
  def up
    rename_index :ingredients, "index_ingredients_on_recipe_id", "index_ingredients_on_meal_id"
  end
end
