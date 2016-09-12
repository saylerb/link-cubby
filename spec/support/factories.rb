FactoryGirl.define do
  sequence(:email) { |n| "#{n}@example.com" }

  factory :user do
    email
    password "password"
    password_confirmation "password"
  end

  sequence(:title) { |n| "#{n} Link Title" }
  sequence(:url) { |n| "http://www.turing.io/#{n}" }

  factory :link do
    title 
    url 
    user
  end
end
