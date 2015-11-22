class CartItemsController < ApplicationController

  def destroy
    @item = current_cart.find_cart_item(params[:id])
    @item.destroy
    @product = @item.product
    redirect_to :back, notice: "已將 #{@product.title} 從購物車刪除"
  end

  def update
    @item = current_cart.find_cart_item(params[:id])

    if @item.product.quantity >= item_params[:quantity].to_i
      @item.update(item_params)
      flash[:success] = "已更新數量"
    else
      flash[:danger] = "數量不足"
    end

    redirect_to carts_path
  end


private

  def item_params
    params.require(:cart_item).permit(:quantity)
  end


end



