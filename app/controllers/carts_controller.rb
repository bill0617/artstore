class CartsController < ApplicationController
before_action :authenticate_user!

  def index
    @products = current_cart.items
  end
end
