class AddIndexToIngredient < ActiveRecord::Migration
  def change
    add_index :ingredients, :recipe_id
  end
end
