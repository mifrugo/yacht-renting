class Addcheckouttobookings < ActiveRecord::Migration[6.0]
  def change
    add_column :bookings, :checkout_id, :string
  end
end
