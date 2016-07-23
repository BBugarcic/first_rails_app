require 'rails_helper'

describe Message do

  context "when parametars are not valid" do
    let(:message) { Message.new(name: "Name", surname: "Surname", email: "b@b.com", content: "message content...") }

    it "is without name" do
      message.name = nil
      expect(message).to_not be_valid
    end

    it "is with forbiden characters in name" do
      message.name = "False5name"
      expect(message).to_not be_valid
    end

    it "is without surname" do
      message.surname = nil
      expect(message).to_not be_valid
    end

    it "is with forbiden characters in surname" do
      message.surname = "False6 /surname"
      expect(message).to_not be_valid
    end

    it "is without email" do
      message.email = nil
      expect(message).to_not be_valid
    end

    it "is not valid email" do
      message.email = "this is not an email"
      expect(message).to_not be_valid
    end

    it "is without content" do
      message.content = nil
      expect(message).to_not be_valid
    end

    it "has too long content" do
      message.content = "1234567890" * 20
      message.content = message.content + "1"
      expect(message).to_not be_valid
    end

    it "has too short content" do
      message.content = "12345678901234"
      expect(message).to_not be_valid
    end

  end
end
