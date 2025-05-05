class OrdersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @orders = current_user.orders.order(created_at: :desc)
  end
  
  def show
    @order = current_user.orders.find(params[:id])
  end
  
  def new
    @cart = current_user.cart
    
    if @cart.empty?
      redirect_to cart_path, alert: "Votre panier est vide"
      return
    end
    
    @order = Order.new
  end
  
  def create
    @cart = current_user.cart
    
    if @cart.empty?
      redirect_to cart_path, alert: "Votre panier est vide"
      return
    end
    
    # Création de la commande
    @order = Order.new(
      user: current_user,
      status: "pending",
      total_price: @cart.total_price
    )
    
    # Ajout des produits à la commande
    @cart.cart_items.each do |item|
      @order.order_items.build(
        product: item.product,
        quantity: item.quantity,
        unit_price: item.product.price
      )
    end
    
    if @order.save
      # Créer une session Stripe
      session = Stripe::Checkout::Session.create({
        payment_method_types: ['card'],
        line_items: @order.order_items.map do |item|
          {
            price_data: {
              currency: 'eur',
              product_data: {
                name: item.product.title,
                images: [item.product.image_url],
              },
              unit_amount: (item.unit_price * 100).to_i,
            },
            quantity: item.quantity,
          }
        end,
        mode: 'payment',
        success_url: order_url(@order) + "?payment_success=true",
        cancel_url: order_url(@order) + "?payment_canceled=true",
      })
      
      # Vider le panier
      @cart.empty!
      
      # Rediriger vers la page de paiement Stripe
      redirect_to session.url, allow_other_host: true
    else
      render :new, status: :unprocessable_entity
    end
  end
end