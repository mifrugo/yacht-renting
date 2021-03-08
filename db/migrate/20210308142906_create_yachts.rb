class CreateYachts < ActiveRecord::Migration[6.0]
  def change
    create_table :yachts do |t|
      t.string :title
      t.text :description
      t.integer :type
      t.decimal :lat
      t.decimal :long

      t.timestamps
    end
  end
end
