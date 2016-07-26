class Comment < ActiveRecord::Base
  validates :body, :user, :product, presence: true
  validates :body, length: { in: 4..100 }
  validates :rating, numericality: { only_integer: true }
  belongs_to :user
  belongs_to :product

  self.per_page = 3

  def self.order_paginate(pages_param)
    page(pages_param).order("created_at DESC")
  end

end
