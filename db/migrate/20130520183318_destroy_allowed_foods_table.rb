class DestroyAllowedFoodsTable < ActiveRecord::Migration
  def up
    drop_table :allowed_food_connections
  end

  def down
    create_table :allowed_food_connections do |t|
      t.references :diet, :null => false
      t.references :food, :null => false

      t.timestamps
    end
  end
end
