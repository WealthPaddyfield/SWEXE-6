class CartItemsController < ApplicationController
  before_action :set_cart_item, only: [:destroy]

  def new
    @products = Product.order(:id)
  end

  def create
    Rails.logger.info "CartItems#create params: #{params.inspect}"

    product = Product.find(params[:product_id])
    cart = current_cart

    qty = params[:quantity].to_i
    qty = 1 if qty <= 0

    item = cart.cart_items.find_by(product_id: product.id)
    if item
      item.quantity += qty
      item.save!
    else
      cart.cart_items.create!(product: product, quantity: qty)
    end

    redirect_to cart_path(cart), notice: "カートに追加しました"
  rescue ActiveRecord::RecordNotFound => e
    redirect_back fallback_location: products_path, alert: "商品が見つかりません"
  rescue ActiveRecord::RecordInvalid => e
    redirect_back fallback_location: products_path, alert: "追加に失敗しました: #{e.record.errors.full_messages.join(', ')}"
  end

  def destroy
    @cart_item.destroy
    redirect_back fallback_location: cart_path(current_cart), notice: "カートから削除しました"
  end

  private

  def set_cart_item
    @cart_item = CartItem.find(params[:id])
  end
end
