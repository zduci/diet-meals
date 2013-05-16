class IngredientRecipeIdCannotBeNull < ActiveRecord::Migration
  def change
    change_column :ingredients, :recipe_id, :integer, :null => false
  end
end
