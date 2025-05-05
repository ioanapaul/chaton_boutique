class Admin::DashboardController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @orders = Order.order(created_at: :desc).limit(10)
    @users = User.order(created_at: :desc).limit(10)
  end
end
