class Product < ActiveRecord::Base
  validates :name, :description, :image_url, :color, presence: true
  validates :name, length: { in: 4..21 }
  validates :description, length: { in: 4..150 }
  validates :price, numericality: { greater_than: 0, message: "must be a number greater than 0" }
  validates :image_url, :url => true
  belongs_to :user
  has_many :orders
  has_many :comments

  scope :special_offers, -> { where( special_offer: true ) }
  scope :not_public_offers, -> { where( public: false ) }
  scope :public_offers, -> { where( public: true ) }

  def self.search_production(search_term)
      where(public: true).where("name ilike ?", "%#{search_term}%")
  end

  def self.search_development(search_term)
    where(public: true).where("name LIKE ?", "%#{search_term}%")
  end

  def self.admin_created
    joins(:user).where( :users => {:admin => true} )
  end

  def self.current_user_created(current_id)
    joins(:user).where("user_id = #{current_id}")
  end

  def self.members_created
    joins(:user).where( :users => {:admin => false} )
  end

  def average_rating
    comments.average(:rating).to_f
  end


  def self.payment_process(payment_params, user)

      #@product = Product.find(params[:product_id])
      #params = payment_params.dup
      @product = Product.find(payment_params[:product_id])
    #  @user = current_user

      Stripe.api_key = "sk_test_nNbonBuIkaBf8JKbUu61Wahr"

      token = payment_params[:stripeToken]

      begin
        charge = Stripe::Charge.create(
          :amount => @product.price, #params[:product_price],
          :currency => "eur",
          :source => token,
          :description => payment_params[:stripeEmail]
        )

        if charge.paid
          Order.create(
            :product_id => @product.id,
            :user_id => user.id,
            :total => @product.price
          )
          MessageMailer.paid_success(user).deliver_now

          # check if user has already buy this product
          if ($redis.hget("ordered_by_#{user.id}:", "#{@product.id}"))
            # count how many times he ordered the same product
            $redis.hincrby("ordered_by_#{user.id}:", "#{@product.id}", 1)
          # if he orders the product for the first time
          else
            $redis.hset("ordered_by_#{user.id}:", "#{@product.id}", 1)
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
