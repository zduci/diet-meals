class CreateUnitOfMeasurements < ActiveRecord::Migration
  def change
    create_table :unit_of_measurements do |t|
      t.string :name, :null => false
      t.string :short_name, :null => false

      t.timestamps
    end
  end
end
