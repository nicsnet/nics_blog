FactoryGirl.define do
  factory :user do
    sequence(:firstname)  { |n| "Person #{n}" }
    sequence(:lastname)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@test.de"}
    password "password"
    password_confirmation "password"
  end

  factory :admin do
    admin true
  end
end
