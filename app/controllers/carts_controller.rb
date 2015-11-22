class CartsController < ApplicationController
before_action :authenticate_user!

  def index
    @products = current_cart.items
  end

  def checkout
    @order = current_user.orders.build
    @info = @order.build_info
  end

  def clean
    current_cart.clean!
    flash[:success] = "已為您清空購物車"
    redirect_to :back
  end
end
