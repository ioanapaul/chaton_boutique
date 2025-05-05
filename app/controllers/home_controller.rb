class HomeController < ApplicationController
  def index
    @products = Product.order(created_at: :desc).limit(8)
  end
  
  def about
  end
  
  def terms
  end
  
  def privacy
  end
end

