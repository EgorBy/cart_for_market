class AddDiscountToCarts < ActiveRecord::Migration[7.1]
  def change
    add_column :carts, :discount, :decimal, default: 0
  end
end
