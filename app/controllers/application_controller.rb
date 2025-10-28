class ApplicationController < ActionController::Base
  helper_method :current_cart

  private

  def current_cart
    if session[:cart_id]
      Cart.find_by(id: session[:cart_id]) || create_new_cart
    else
      create_new_cart
    end
  end

  def create_new_cart
    cart = Cart.create!
    session[:cart_id] = cart.id
    cart
  end
end
