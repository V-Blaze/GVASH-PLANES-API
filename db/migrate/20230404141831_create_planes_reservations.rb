class CreatePlanesReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :plane_reservations do |t|
      t.date :date
      t.integer :duration
      t.time :start_time
      t.time :end_time

      t.references :user, null: false, foreign_key: true
      t.references :plane, null: false, foreign_key: true

      t.timestamps
    end
  end
end
