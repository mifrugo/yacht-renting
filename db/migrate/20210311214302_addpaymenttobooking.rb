class Addpaymenttobooking < ActiveRecord::Migration[6.0]
  def change
    add_column :bookings, :payment_status, :string, default: 'pending'
  end
end
