class CreatePlanesReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :planes_reservations do |t|
      t.date :date
      t.time :duration

      t.references :user, null: false, foreign_key: true
      t.references :plane, null: false, foreign_key: true

      t.timestamps
    end
  end
end
