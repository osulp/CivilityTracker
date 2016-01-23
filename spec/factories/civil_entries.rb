# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :civil_entry do
    sequence(:serial) {|n| n}
    reason "This is a reason"
    address "Corvallis, OR"
    reviewed true
    trait :unreviewed_civil_entry do
      reviewed false
    end
  end
end
