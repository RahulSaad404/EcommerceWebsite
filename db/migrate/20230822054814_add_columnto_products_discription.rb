class AddColumntoProductsDiscription < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :discription, :string
    add_column :products, :seller, :string 
  end
end
