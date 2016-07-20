class Product < ActiveRecord::Base
  validates :name, :description, :image_url, :color, presence: true
  validates :name, length: { in: 4..21 }
  validates :description, length: { in: 4..150 }
  validates :price, numericality: { message: "must be a number" }
  validates :image_url, :url => true
  belongs_to :user
  has_many :orders
  has_many :comments

  def average_rating
    comments.average(:rating).to_f
  end
end
