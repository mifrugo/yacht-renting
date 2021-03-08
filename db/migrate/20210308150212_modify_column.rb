class ModifyColumn < ActiveRecord::Migration[6.0]
  def change
    rename_column :yachts, :type, :booking_type
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
