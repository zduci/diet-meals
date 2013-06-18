class AddNotNullConstraintsToStars < ActiveRecord::Migration
  def change
    change_column :stars, :diet_id, :integer, :null => false
    change_column :stars, :meal_id, :integer, :null => false
    change_column :stars, :user_id, :integer, :null => false
  end
end
