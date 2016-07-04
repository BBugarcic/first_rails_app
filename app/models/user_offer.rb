class UserOffer < ActiveRecord::Base
  validates :name, :category, :description, :color, presence: true, length: { minimum: 4 }
  validates :price, presence: true, length: {minimum: 2}

end
