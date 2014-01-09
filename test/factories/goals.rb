# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :goal do
    user_id nil
    target 1
    period 1
    period_type "MyString"
    start_date "2014-01-08"
  end
end
