class ChangeYachtForeignKeys < ActiveRecord::Migration[6.0]
  def change
    add_reference :yachts, :location 
  end
end
