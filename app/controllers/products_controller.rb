class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  #before_action :convert_price_in_cents, only: [:create, :update]
  # GET /products
  # GET /products.json
  def index

    if params[:q]
      search_term = params[:q]
      # return our filtered list here
      @products = (Rails.env == 'production') ? Product.search_production(search_term) : Product.search_development(search_term)

    else
      @products = Product.where(public: true)
    end

    @special_offers = Product.special_offers
    logger.debug "------------"
    logger.debug "Current number of products in special_offers is #{@special_offers.size}"
    logger.debug "------------"
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @comments = @product.comments.order_paginate(params[:page])
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
    authorize! :edit, @product
  end

  # POST /products
  # POST /products.json
  def create
    updated_params = convert_price_to_cent(product_params)
    @product = Product.new(updated_params)
    @product.user_id = current_user.id
    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    updated_params = convert_price_to_cent(product_params)
    respond_to do |format|
      if @product.update(updated_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def user_offers
    if(!current_user.admin?)
      @products  = Product.current_user_created(current_user.id)
    logger.debug "------------"
    logger.debug "Current user has #{@products.size} products "
    logger.debug "------------"
    else
      @products = Product.members_created
    end
  end

  def our_offers
    if(!current_user.admin?)
      redirect_to products_path
    else
      @products = Product.admin_created
    logger.debug "------------"
    logger.debug "Admins have #{@products.size} products "
    logger.debug "------------"
    end
  end

  def not_public_offers
      @products = Product.not_public_offers
    logger.debug "------------"
    logger.debug "Total number of pending offers is #{@products.size}"
    logger.debug "------------"
  end

  def special_offers
    @products = Product.special_offers
  end

  private

    def convert_price_to_cent(submitted_params)
      submitted_params[:price] = submitted_params[:price].to_f * 100 #convert to cents
      submitted_params
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :description, :image_url, :color, :price, :user_id, :public, :special_offer)
    end
end
