class Comment < ActiveRecord::Base
  validates :body, :user, :product, presence: true
  validates :body, length: { in: 4..100 }
  validates :rating, numericality: { only_integer: true }
  belongs_to :user
  belongs_to :product
end
