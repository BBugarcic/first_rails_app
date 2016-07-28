require "rails_helper"

describe UsersController, :type => :controller do

  describe "GET #show" do
    let(:user) { User.create!(email: "some@email.com", password: "anything") }
    let(:user2) { User.create!(email: "other@example.com", password: "otherone")}

    context "User is logged in" do
      before do
        sign_in user
      end

      it "Loads correct user details" do
        get :show, id: user.id

        expect(response).to be_success
        expect(response).to have_http_status(200)
        expect(assigns(:user)).to eq user
      end


    end

    context "No user is logged in" do
      it "redirects to login" do
        get :show, id: user.id
        expect(response).to redirect_to(new_user_session_path)
      end
    end


    context "authorization" do
      before do
        sign_in user
      end

      it "logged in user routing" do
        get :show, id: user.id
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "not logged user routing" do
        get :show, id: user2.id
        expect(response).to_not be_success
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(products_path)
      end

    end

  end

  describe "GET #edit" do
    let(:user) { User.create!(email: "some@email.com", password: "anything") }
    let(:user2) { User.create!(email: "other@example.com", password: "otherone")}

    context "User is logged in" do
      before do
        sign_in user
      end

      it "Loads correct user details" do
        get :edit, id: user.id
        expect(response).to be_success
        expect(response).to have_http_status(200)
        expect(assigns(:user)).to eq user
      end
    end

    context "No user is logged in" do
      it "redirects to login" do
        get :edit, id: user.id
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "authorization" do
      before do
        sign_in user
      end

      it "logged in user routing" do
        get :edit, id: user.id
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "not logged user routing" do
        get :edit, id: user2.id
        expect(response).to_not be_success
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(products_path)
      end

    end

  end

end
