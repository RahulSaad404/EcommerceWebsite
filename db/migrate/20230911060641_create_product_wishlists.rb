class CreateProductWishlists < ActiveRecord::Migration[6.0]
  def change
    create_table :product_wishlists do |t|
      t.belongs_to :product, null: false, foreign_key: true
      t.belongs_to :wishlist, null: false, foreign_key: true
      t.timestamps
    end
  end
end
