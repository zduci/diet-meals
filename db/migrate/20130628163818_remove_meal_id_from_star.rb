class RemoveMealIdFromStar < ActiveRecord::Migration
  def change
    remove_column :stars, :meal_id
  end
end
