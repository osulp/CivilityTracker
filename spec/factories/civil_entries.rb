# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :civil_entry do
    sequence(:serial) {|n| n}
    reason "This is a reason"
    reviewed true
  end
  factory :unreviewed_civil_entry, :class => CivilEntry do
    sequence(:serial) {|n| n}
    reason "This is a reason"
    reviewed false
  end
end
