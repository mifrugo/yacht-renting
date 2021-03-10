class AddColumnToYachts < ActiveRecord::Migration[6.0]
  def change
    add_column :yachts, :price_per_day, :integer
  end
end
