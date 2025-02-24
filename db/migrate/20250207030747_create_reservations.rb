class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.references :room, null: false, foreign_key: true
      t.date :check_in_date, null: false
      t.date :check_out_date, null: false
      t.integer :guest_count, null: false, default: 1
      t.integer :total_price, null: false, default: 0

      t.timestamps
    end
  end
end
