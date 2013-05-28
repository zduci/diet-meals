class RenameRecipesToMeals < ActiveRecord::Migration
  def change
    rename_table :recipes, :meals
  end
end
