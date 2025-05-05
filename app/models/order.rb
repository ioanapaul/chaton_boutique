class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items
  
  validates :status, presence: true
  validates :total_price, presence: true, numericality: { greater_than: 0 }
  
  enum status: {
    pending: 'pending',
    paid: 'paid',
    cancelled: 'cancelled',
    delivered: 'delivered'
  }
  
  def to_s
    "Order ##{id}"
  end
end
