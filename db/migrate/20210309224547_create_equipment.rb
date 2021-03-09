class CreateEquipment < ActiveRecord::Migration[6.0]
  def change
    create_table :equipment do |t|
      t.references :equipment_type, null: false, foreign_key: true
      t.references :yacht, null: false, foreign_key: true

      t.timestamps
    end
  end
end
