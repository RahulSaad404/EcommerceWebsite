class CreateProductReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :product_reviews do |t|
      t.integer :product_id
      t.integer :user_id
      t.string :review
      t.timestamps
    end
  end
end
