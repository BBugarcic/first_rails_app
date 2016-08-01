FactoryGirl.define do
  sequence(:email) { |n| "user#{n}@example.com" }
  # user factory without associated products
  factory :user do
    email
    password "imagine"
    first_name "John"
    last_name "Lenon"
    admin false
    # user factory with products
    factory :user_with_products do
      transient do
        products_count 5
      end

      after(:create) do |user, evaluator|
        create_list(:product, evaluator.products_count, user: user)
      end
    end

    factory :user_with_comments do
      transient do
        comments_count 5
      end

      after(:create) do |user, evaluator|
        create_list(:comment, evaluator.comments_count, user: user)
      end
    end

  end

  # inheritance
  factory :admin, parent: :user do
    admin true

    factory :admin_with_products do
      transient do
        products_count 5
      end

      after(:create) do |user, evaluator|
        create_list(:product, evaluator.products_count, user: user)
      end
    end
  end


end
