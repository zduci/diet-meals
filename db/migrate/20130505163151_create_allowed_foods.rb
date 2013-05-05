class CreateAllowedFoods < ActiveRecord::Migration
  def change
    create_table :allowed_foods do |t|
      t.integer :diet_id, :null => false
      t.integer :food_id, :null => false

      t.timestamps
    end
  end
end
