FactoryGirl.define do
  factory :article do
    title "MyString"
    content "MyText"
    user
    published false
  end
end

