FactoryGirl.define do
  sequence(:email) { |n| "#{n}@example.com" }

  factory :user do
    email
    password "password"
    password_confirmation "password"
  end
end
