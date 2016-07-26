class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index

    if params[:q]
      search_term = params[:q]
      # return our filtered list here
      if Rails.env == "production"
        like = "ilike"
        @products = Product.search(search_term, like)
      else
        like = "LIKE"
        @products = Product.search(search_term, like)
      end
    else
        @products = Product.where(public: true)
    end

    @special_offers = Product.special_offers
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
    @product = Product.new(product_params)
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
    respond_to do |format|
      if @product.update(product_params)
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
    else
      @products = Product.members_created
    end
  end

  def our_offers
    @products = Product.admin_created
  end

  def not_public_offers
      @products = Product.not_public_offers
  end

  def special_offers
    @products = Product.special_offers
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :description, :image_url, :color, :price, :user_id, :public, :special_offer)
    end
end
