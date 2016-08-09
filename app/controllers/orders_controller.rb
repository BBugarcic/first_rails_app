class OrdersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    #@orders = Product.joins(:orders).where( :orders => {:user_id => "#{current_user.id}"})

    @ordered_products_ids = $redis.lrange("ordered_by_#{current_user.id}:", 0, -1)
    @orders = Product.where( :id => @ordered_products_ids)
  end

  def show
  end

  def new
  end

  def create
  end

  def destroy
  end

end
