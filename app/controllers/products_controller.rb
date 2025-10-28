class ProductsController < ApplicationController
  before_action :set_product, only: [:destroy]

  def index
    @products = Product.order(:id)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path, notice: "商品を追加しました"
    else
      render :new
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path, notice: "商品を削除しました"
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :price)
  end
end
