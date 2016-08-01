FactoryGirl.define do

  factory :comment do
    body "Any comment"  
    rating 5
    product
    user
  end
end
