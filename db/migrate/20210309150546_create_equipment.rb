class CreateEquipment < ActiveRecord::Migration[6.0]
  def change
    create_table :equipment do |t|
      t.references :yacht, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
