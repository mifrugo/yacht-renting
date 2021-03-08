class ChangeLocationForeignKey < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :locations, :yachts
  end
end
