class AddColumnBedToYachts < ActiveRecord::Migration[6.0]
  def change
    add_column :yachts, :bed_space, :integer, default: 0
  end
end
