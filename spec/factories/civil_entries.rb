# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :civil_entry do
    sequence(:serial) {|n| n}
    reason "This is a reason"
  end
end
