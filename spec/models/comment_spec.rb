require 'rails_helper'

describe Comment do

  context "when not complete" do
    let(:comment) { Comment.new(body: "Any comment", rating: 5 )}

    it "is without body" do
      comment.body = nil
      expect(comment).to_not be_valid
    end

    it "has too short body" do
      comment.body = "123"
      expect(comment).to_not be_valid
    end

    it "has too long body" do
      comment.body = "1234567890" * 10
      comment.body = comment.body + "1"
      expect(comment).to_not be_valid
    end

    it "is without rating" do
      comment.rating = nil
      expect(comment).to_not be_valid
    end

    it "has rating in letters" do
      comment.rating = "abc"
      expect(comment).to_not be_valid
    end

  end
end
