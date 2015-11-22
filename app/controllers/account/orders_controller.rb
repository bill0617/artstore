class Account::OrdersController < ApplicationController
before_action :authenticate_user!
  def index
    @orders = current_user.orders.order("id DESC")
  end

  def show
    @order = current_user.orders.find_by_token(params[:id])
    @order_info = @order.info
    @order_items = @order.items
  end
end
