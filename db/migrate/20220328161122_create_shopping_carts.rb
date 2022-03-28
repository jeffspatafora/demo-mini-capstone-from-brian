class CreateShoppingCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :shopping_carts do |t|
      t.integer "order_id"
      t.integer "user_id"
      t.integer "product_id"
      t.integer "quantity"
      t.boolean "carted", default: false
      t.boolean "purchased", default: false
      t.boolean "removed", default: false
      
      t.timestamps
    end
  end
end
