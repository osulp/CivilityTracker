# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :civil_entry do
    serial 1
    reason "MyText"
  end
end
