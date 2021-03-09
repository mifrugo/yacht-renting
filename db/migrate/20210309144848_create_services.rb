class CreateServices < ActiveRecord::Migration[6.0]
  def change
    create_table :services do |t|
      t.references :yacht, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end