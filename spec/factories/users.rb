FactoryGirl.define do
  factory :user do
    firstname 'Mr'
    lastname 'Blogger'
    email 'blogger@test.de'
    password 'password'
    password_confirmation 'password'
  end
end
