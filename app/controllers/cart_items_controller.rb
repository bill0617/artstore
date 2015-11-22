class CartItemsController < ApplicationController

  def destroy
    @item = current_cart.cart_items.find_by(product_id: (params[:id]))
    @item.destroy
    @product = @item.product
    redirect_to :back, notice: "已將 #{@product.title} 從購物車刪除"
  end

  def update
    @item = current_cart.cart_items.find_by(product_id: params[:id])
    @item.update(item_params)

    redirect_to carts_path
  end


private

  def item_params
    params.require(:cart_item).permit(:quantity)
  end


end



