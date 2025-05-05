class CartItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart_item, only: [:update, :destroy]
  
  def create
    @cart = current_user.cart
    product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i || 1
    
    @cart.add_product(product, quantity)
    
    redirect_to cart_path, notice: "#{product.title} ajouté au panier!"
  end
  
  def update
    if @cart_item.update(cart_item_params)
      redirect_to cart_path, notice: "Quantité mise à jour!"
    else
      redirect_to cart_path, alert: "Impossible de mettre à jour la quantité"
    end
  end
  
  def destroy
    @cart_item.destroy
    redirect_to cart_path, notice: "Produit retiré du panier"
  end
  
  private
  
  def set_cart_item
    @cart_item = current_user.cart.cart_items.find(params[:id])
  end
  
  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end
end
