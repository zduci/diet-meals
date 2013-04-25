class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.text :instructions, :null => false
      t.integer :duration

      t.timestamps
    end
  end
end
