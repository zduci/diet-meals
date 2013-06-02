class CreateDietClassifications < ActiveRecord::Migration
  def change
    create_table :diet_classifications do |t|
      t.references :diet
      t.references :meal

      t.timestamps
    end
  end
end
