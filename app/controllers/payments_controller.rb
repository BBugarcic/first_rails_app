class PaymentsController < ApplicationController



  def create

    @user = current_user
    Product.payment_process(params, @user)
  end
end
