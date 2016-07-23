require 'rails_helper'

describe User do

  context "when parametars are not valid" do
    let(:user) { User.new(email: "any@mail.com", password: "anything")}

    it "has no email" do
      user.email = nil
      expect(user).to_not be_valid
    end

    it "has no password" do
      user.password = nil
      expect(user).to_not be_valid
    end

    it "has too short password" do
      user.password = "12345"
      expect(user).to_not be_valid
    end
  end

end
