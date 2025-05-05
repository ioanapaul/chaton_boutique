class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items
  
  def add_product(product, quantity = 1)
    item = cart_items.find_by(product: product)
    
    if item
      item.quantity += quantity
      item.save
    else
      cart_items.create(product: product, quantity: quantity)
    end
  end
  
  def total_price
    cart_items.sum { |item| item.product.price * item.quantity }
  end
  
  def empty?
    cart_items.empty?
  end
  
  def empty!
    cart_items.destroy_all
  end
end