class CartsController < ApplicationController
  def index
    @cart = current_cart
    @carts = Cart.order(created_at: :desc).limit(10) # 管理・デバッグ用簡易表示
  end

  def show
    @cart = Cart.find(params[:id])
    @items = @cart.cart_items.includes(:product)
  end
end
