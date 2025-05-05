class CartsController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @cart = current_user.cart
  end
  
  def update
    @cart = current_user.cart
    product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i || 1
    
    @cart.add_product(product, quantity)
    
    redirect_to @cart, notice: "#{product.title} ajouté au panier!"
  end
end