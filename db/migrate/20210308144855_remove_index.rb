class RemoveIndex < ActiveRecord::Migration[6.0]
  def change
    remove_column :locations, :yacht_id
  end
end
