class AddUserReferenceToYachts < ActiveRecord::Migration[6.0]
  def change
    add_reference :yachts, :user, null: false, foreign_key: true
  end
end
