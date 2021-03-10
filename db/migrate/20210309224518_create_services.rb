class CreateServices < ActiveRecord::Migration[6.0]
  def change
    create_table :services do |t|
      t.references :service_type, null: false, foreign_key: true
      t.references :yacht, null: false, foreign_key: true

      t.timestamps
    end
  end
end
