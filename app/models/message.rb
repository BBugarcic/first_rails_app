class Message < ActiveRecord::Base
  validates :name, :surname, :email, :content, presence: true 
  validates :name, :surname, format: {with: /\A[a-zA-Z]+(?: [a-zA-Z]+)?\z/,
    message: "only allows letters and one white space between names" }
  validates :email, format: {
    with: /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
    message: "It looks like something is wrong with your email address"
  }

end
