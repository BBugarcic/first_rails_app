class UserOffer < ActiveRecord::Base
  validates :name, :category, :description, :color, presence: true, length: { minimum: 5 }
  validates :price, presence: true, length: {minimum: 2}

end
