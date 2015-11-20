class Admin::ProductsController < ApplicationController
  def new
    @product = Product.new
  end

  def create
    @product = Product.create(product_params)

    if @product.save
      redirect_to admin_products
    else
      render :new
    end

  end

private

  def product_params
    params.require(:product).permit(:title, :description, :quantity, :price)
  end

end


