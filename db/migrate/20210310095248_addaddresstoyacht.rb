class Addaddresstoyacht < ActiveRecord::Migration[6.0]
  def change
    add_column :yachts, :address, :string
  end
end
