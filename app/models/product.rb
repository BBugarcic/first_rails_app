class Product < ActiveRecord::Base
  validates :name, :description, :image_url, :color, presence: true
  validates :name, length: { in: 4..21 }
  validates :description, length: { in: 4..150 }
  validates :price, numericality: { greater_than: 0, message: "must be a number greater than 0" }
  validates :image_url, :url => true
  belongs_to :user
  has_many :orders
  has_many :comments

  scope :special_offers, -> { where( special_offer: true ) }
  scope :not_public_offers, -> { where( public: false ) }
  scope :public_offers, -> { where( public: true ) }

  def self.search(search_term, like)
      where("name #{like} ?", "%#{search_term}%")
  end

  def self.admin_created
    joins(:user).where( :users => {:admin => true} )
  end

  def self.current_user_created(current_id)
    joins(:user).where("user_id = #{current_id}")
  end

  def self.members_created
    joins(:user).where( :users => {:admin => false} )
  end

  def average_rating
    comments.average(:rating).to_f
  end
end
