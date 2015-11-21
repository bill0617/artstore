class Cart < ActiveRecord::Base
  has_many :cart_items, dependent: :destroy
  has_many :items, through: :cart_items, source: :product



  def add_product_to_cart(product)
    items << product
  end

  def total_price
    cart_items.inject(0) {|sum, cart_item| sum + (cart_item.product.price * cart_item.product.quantity)}
  end

end
