require "rails_helper"

describe ProductsController, :type => :controller do
  # only public offers are shown
  describe "GET #index" do

    context "when special offers exist" do
      before do
        3.times do
          FactoryGirl.create(:special_offer)
        end
      end

      it "loads special_offers" do
        get :index , special_offer: true
        expect(assigns(:special_offers).size).to eq(3)
      end
    end

    context "when public offers exit" do
      before do
        3.times do
          FactoryGirl.create(:product)
        end

        7.times do
          FactoryGirl.create(:non_public_product)
        end
      end

      it "show public offers to any user" do
        get :index
        expect(response).to be_success
        expect(response).to have_http_status(200)
        expect(assigns(:products).size).to eq(3)
      end
    end

    context "when params in search exist" do
      before do
        FactoryGirl.create(:product, name: "bike2")
        FactoryGirl.create(:non_public_product, name: "bike2")
      end
      it "returns correct results" do
        get :index, q: "bike2"
        expect(assigns(:products).size).to eq(1)
      end
    end
  end

  describe "GET #user_offers" do
    # user see only his offers
    context "when user logged in" do
      before do
        @user = FactoryGirl.create(:user)
        @user_1 = FactoryGirl.create(:user_with_products, products_count: 10)
        @user_2 = FactoryGirl.create(:user_with_products, products_count: 13)
        sign_in @user_2
      end

      it "loads offers of logged in user" do
        get :user_offers, id: @user_2
        expect(assigns(:products).size).to eq(13)
      end

      context "when admin logged in" do
        before do
          admin = FactoryGirl.create(:admin)
          sign_in admin
        end

        it "loads members' created offers" do
          get :user_offers
          expect(assigns(:products).size).to eq(23)
        end
      end
    end
  end

  describe "GET #our_offers" do
    before do
      @user = FactoryGirl.create(:user_with_products, products_count: 10)
      @admin_1 = FactoryGirl.create(:admin_with_products, products_count: 7)
      @admin_2 = FactoryGirl.create(:admin_with_products, products_count: 6)
    end

    context "when admin logged in" do
      before do
        sign_in @admin_1
      end

      it "loads admin created offers" do
        get :our_offers
        expect(assigns(:products).size).to eq(13)
      end
    end

    context "when user logged in" do
      before do
        sign_in @user
      end

      it "redirect to products" do
        get :our_offers
        expect(response).to_not be_success
        expect(response).to redirect_to(products_path)
      end

    end
  end

  describe "GET #edit" do
    before do
      @user = FactoryGirl.create(:user)
      @admin = FactoryGirl.create(:admin)
      @product_user_made = FactoryGirl.create(:product, user: @user)
      @product_admin_made = FactoryGirl.create(:product, user: @admin)
    end

    context "when product belongs to logged in user" do
      before do
        sign_in @user
      end

      it "can edit only his products" do
        get :edit, id: @product_user_made.id
        expect(response).to be_success
        expect(response).to have_http_status(200)
        expect(response).to render_template("edit")
      end

      it "can not edit other's products" do
        get :edit, id: @product_admin_made.id
        expect(response).to_not be_success
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(products_path)
      end
    end

    context "when admin logged in" do
      before do
        sign_in @admin
      end

      it "can edit admin products" do
        get :edit, id: @product_admin_made.id
        expect(response).to be_success
        expect(response).to have_http_status(200)
        expect(response).to render_template("edit")
      end

      it "can edit any other product" do
        get :edit, id: @product_user_made.id
        expect(response).to be_success
        expect(response).to have_http_status(200)
        expect(response).to render_template("edit")
      end
    end
  end

  describe "GET #show" do
    # when product has products it shows them
    context "when product has comments" do
      before do
        @product = FactoryGirl.create(:product_with_comments, comments_count: 2)
      end

      it "loads all comments" do
        get :show, id: @product.id
        expect(response).to be_success
        expect(response).to have_http_status(200)
        expect(assigns(:comments).size).to eq(2)
      end
    end

    context "when product has no comments" do
      before do
        @product = FactoryGirl.create(:product)
      end

      it "loads the product" do
        get :show, id: @product.id
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
    end

  end
end
