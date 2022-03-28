class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price
      t.text :description
      t.integer :quantity
      t.integer :supplier_id

      t.timestamps
    end
  end
end
