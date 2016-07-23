require 'rails_helper'

describe Product do

  context "when the product has comments" do
    before do
      @product = Product.create!(name: "race bike", description: "As good as new", image_url: "https://res.cloudinary.com/dnkyfvpgn/image/upload/v1468680066/vintage-bicycle-825736_1920_ld8usv.jpg", color: "blue", price: 150.5)
      @user = User.create!(email: "boom@boom.com", password: "testerica")
      @product.comments.create!(rating: 1, user: @user, body: "Awful bike!")
      @product.comments.create!(rating: 3, user: @user, body: "This one is ok!")
      @product.comments.create!(rating: 5, user: @user, body: "Exellent!")
    end

    it "returns the average rating of all comments" do
      expect(@product.average_rating).to eq 3
    end
  end

  context "when parametars are not valid" do
    let(:product) { Product.new(name: "race bike", description: "As good as new", image_url: "https://res.cloudinary.com/dnkyfvpgn/image/upload/v1468680066/vintage-bicycle-825736_1920_ld8usv.jpg", color: "blue", price: 150.5) }

    it "is wihout name" do
      product.name = nil
      expect(product).to_not be_valid
    end

    it "is with too short name" do
      product.name = "123"
      expect(product).to_not be_valid
    end

    it "is with too long name" do
      product.name = "test test test test 22"
      expect(product).to_not be_valid
    end

    it "is without description" do
      product.description = nil
      expect(product).to_not be_valid
    end

    it "is with too short description" do
      product.description = "123"
      expect(product).to_not be_valid
    end

    it "is with too long description" do
      product.description = "1234567890" * 15
      product.description = product.description + "1"
      expect(product).to_not be_valid
    end

    it "is without image_url" do
      product.image_url = nil
      expect(product).to_not be_valid
    end

    it "is with wrong image_url format" do
      product.image_url = "this is not an URL"
      expect(product).to_not be_valid
    end

    it "is without color" do
      product.color = nil
      expect(product).to_not be_valid
    end

    it "is without price" do
      product.price = nil
      expect(product).to_not be_valid
    end

    it "is with negative price" do
      product.price = -3
      expect(product).to_not be_valid
    end
  end

end
