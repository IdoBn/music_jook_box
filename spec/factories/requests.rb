# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :request do
    author "MyString"
    played false
    thumbnail "MyString"
    url "MyString"
    party_id 1
  end
end
