class Admin::ProductsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_product, only: [:edit, :update, :destroy]
  
  def index
    @products = Product.all.order(created_at: :desc)
  end
  
  def new
    @product = Product.new
  end
  
  def create
    @product = Product.new(product_params)
    
    if @product.save
      redirect_to admin_products_path, notice: "Produit créé avec succès!"
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
  end
  
  def update
    if @product.update(product_params)
      redirect_to admin_products_path, notice: "Produit mis à jour avec succès!"
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @product.destroy
    redirect_to admin_products_path, notice: "Produit supprimé avec succès!"
  end
  
  private
  
  def set_product
    @product = Product.find(params[:id])
  end
  
  def product_params
    params.require(:product).permit(:title, :description, :price, :image_url)
  end
end

# Ajoutons des méthodes d'authentification au ApplicationController
# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  helper_method :current_user, :user_signed_in?, :admin_signed_in?
  
  private
  
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
  
  def user_signed_in?
    current_user.present?
  end
  
  def admin_signed_in?
    user_signed_in? && current_user.admin?
  end
  
  def authenticate_user!
    unless user_signed_in?
      redirect_to login_path, alert: "Vous devez être connecté pour accéder à cette page"
    end
  end
  
  def authenticate_admin!
    unless admin_signed_in?
      redirect_to root_path, alert: "Accès non autorisé"
    end
  end
end