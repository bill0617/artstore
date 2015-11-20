class Admin::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required
  layout 'admin'

  def index
    @products = Product.all
  end


  def new
    @product = Product.new
    @photo = @product.build_photo
  end

  def create
    @product = Product.create(product_params)

    if @product.save
      redirect_to products_path, notice: "成功新增"
    else
      render :new
    end

  end

  def edit
    @product = Product.find(params[:id])

    if !@product.photo.present?
      @photo = @product.build_photo
    else
      @photo = @product.photo
    end
  end

  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      redirect_to products_path
    else
      render :edit
    end
  end

private

  def product_params
    params.require(:product).permit(:title, :description, :quantity, :price,
                                      photo_attributes: [:image, :id])
  end



end


