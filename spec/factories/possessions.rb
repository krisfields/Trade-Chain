# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :possession do
    name "MyString"
    description "MyString"
    user_id 1
  end
end
