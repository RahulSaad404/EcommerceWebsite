class AddColumsToUsersForDetails < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :dob, :date
    add_column :users, :address, :string
    add_column :users, :mob_no, :integer
  end
end
