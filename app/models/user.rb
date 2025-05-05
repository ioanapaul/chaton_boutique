class User < ApplicationRecord
  has_secure_password
  
  has_one :cart, dependent: :destroy
  has_many :orders, dependent: :destroy
  
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  
  after_create :create_cart
  
  private
  
  def create_cart
    Cart.create(user: self)
  end
end