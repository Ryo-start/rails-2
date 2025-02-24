class AddNightsCountToReservations < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :nights, :integer
  end
end
