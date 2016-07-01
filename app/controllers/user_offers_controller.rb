class UserOffersController < ApplicationController

  def index
    @user_offer = UserOffer.all
  end

  def show
    @user_offer = UserOffer.find(params[:id])
  end

  def new
    @user_offer = UserOffer.new
    #@user_offer = UserOffer.find(params[:id])
  end

  def edit
    @user_offer = UserOffer.find(params[:id])
  end

  def create
    # render plain: params[:user_offer].inspect
    @user_offer = UserOffer.new(user_offer_params)

    if @user_offer.save
      redirect_to @user_offer
    else
      render "new"
    end
  end

  def update
    @user_offer = UserOffer.find(params[:id])

    if @user_offer.update(user_offer_params)
      redirect_to @user_offer
    else
      render "edit"
    end
  end

  def destroy
    @user_offer = UserOffer.find(params[:id])
    @user_offer.destroy

    redirect_to user_offers_path
  end

private
  #def set_user_offer
  #  @user_offer = UserOffer.find(params[:id])
  #end

  def user_offer_params
    params.require(:user_offer).permit(:name, :category, :description, :color, :price)
  end

end
