class CreateStars < ActiveRecord::Migration
  def change
    create_table :stars do |t|
      t.references :diet
      t.references :meal
      t.references :user

      t.timestamps
    end
  end
end
