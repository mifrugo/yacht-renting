class AddColumnToBooking < ActiveRecord::Migration[6.0]
  def change
    add_column :bookings, :review, :boolean, default: 0
  end
end
