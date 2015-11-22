class Order < ActiveRecord::Base
  belongs_to :user
  before_create :generate_token
  has_many :items, class_name: "OrderItem", dependent: :destroy
  has_one :info, class_name: "OrderInfo", dependent: :destroy

  accepts_nested_attributes_for :info

  def build_item_cache_from_cart(cart)
    cart.items.each do |cart_item|
      item = items.build
      item.product_name = cart_item.title
      item.quantity = cart_item.quantity
      item.price = cart_item.price
      item.save
    end
  end

  def calculate_total!(cart)
    self.total = cart.total_price
    self.save

  end

  def generate_token
    self.token = SecureRandom.uuid
  end

#變更付款方法欄位
  def set_payment_method!(method)
    self.update_columns(payment_method: method)
  end

  def pay!
    self.update_columns(is_paid: true)
  end
end
