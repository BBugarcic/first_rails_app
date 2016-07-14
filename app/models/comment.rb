class Comment < ActiveRecord::Base
  validates :body, :user, :product, presence: true
  validates :rating, numericality: { only_integer: true }
  belongs_to :user
  belongs_to :product
end
