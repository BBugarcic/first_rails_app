class PaymentsController < ApplicationController

  def create

    @product = Product.find(params[:product_id])

    @user = current_user

    Stripe.api_key = "sk_test_nNbonBuIkaBf8JKbUu61Wahr"

    token = params[:stripeToken]

    begin
      charge = Stripe::Charge.create(
        :amount => @product.price, #params[:product_price],
        :currency => "eur",
        :source => token,
        :description => params[:stripeEmail]
      )

      if charge.paid
        Order.create(
          :product_id => @product.id,
          :user_id => @user.id,
          :total => @product.price
        )
        MessageMailer.paid_success(@user).deliver_now

        # check if user has already buy this product
        if ($redis.hget("ordered_by_#{@user.id}:", "#{@product.id}"))
          # count how many times he ordered the same product
          $redis.hincrby("ordered_by_#{@user.id}:", "#{@product.id}", 1)
        # if he orders the product for the first time
        else
          $redis.hset("ordered_by_#{@user.id}:", "#{@product.id}", 1)
        end
      end

    rescue Stripe::CardError => e
      # the card has been declined
      body = e.json_body
      err = body[:error]
      flash[:error] = "Unfortunately, there was an error processing your payment: #{err[:message]}"
      redirect_to product_path(@product)
    end

  end
end
