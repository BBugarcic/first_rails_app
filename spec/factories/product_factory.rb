FactoryGirl.define do

  factory :product do
    name "bike"
    description "new bre"
    image_url "http://www.test.com"
    color "black"
    price "100"
    public true
    user

    factory :product_with_comments do
      transient do
        comments_count 5
      end

      after(:create) do |product, evaluator|
        create_list(:comment, evaluator.comments_count, product: product)
      end
    end
  end

  factory :non_public_product, parent: :product do
    public false
  end

  factory :special_offer, parent: :product do
    special_offer true
  end


end
