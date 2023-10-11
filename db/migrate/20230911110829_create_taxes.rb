class CreateTaxes < ActiveRecord::Migration[6.0]
  def change
    create_table :taxes do |t|
      t.integer :tax_percent
      t.timestamps
    end
  end
end
