class Order < ActiveRecord::Base
  belongs_to :user
  before_create :generate_token
  has_many :items, class_name: "OrderItem", dependent: :destroy
  has_one :info, class_name: "OrderInfo", dependent: :destroy

  accepts_nested_attributes_for :info

  def build_item_cache_from_cart(cart)
    cart.cart_items.each do |cart_item|
      item = items.build
      item.product_name = cart_item.product.title
      item.quantity = cart_item.quantity
      item.price = cart_item.product.price
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



  #AASM
   include AASM

  aasm do
    state :order_placed, initial: true
    state :paid
    state :shipping
    state :shipped
    state :order_canceled
    state :good_returned


    event :make_payment, after_commit: :pay! do
      transitions from: :order_placed, to: :paid
    end

    event :ship do
      transitions from: :paid,         to: :shipping
    end

    event :deliver do
      transitions from: :shipping,     to: :shipped
    end

    event :return_good do
      transitions from: :shipped,      to: :good_returned
    end

    event :cancel_order do
      transitions from: [:order_placed, :paid], to: :order_canceled
    end
  end

end
