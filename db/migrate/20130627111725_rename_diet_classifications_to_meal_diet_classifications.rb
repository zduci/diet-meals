class RenameDietClassificationsToMealDietClassifications < ActiveRecord::Migration
  def change
    rename_table :diet_classifications, :meal_diet_classifications
  end
end
