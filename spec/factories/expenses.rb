# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :expense do
    title "MyString"
    details "MyText"
    amount ""
    date ""
  end
end
