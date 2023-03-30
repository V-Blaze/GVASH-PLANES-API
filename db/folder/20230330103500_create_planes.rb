class CreatePlanes < ActiveRecord::Migration[7.0]
  def change
    create_table :planes do |t|
      t.string :name
      t.string :type
      t.text :description
      t.string :image
      t.integer :price
      t.string :model
      t.date :year_of_manufacture
      t.time :life_span
      t.float :fees

      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
