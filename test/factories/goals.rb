# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :goal do
    user 
    target 1
    period_type "month"
    start_date "2014-01-08"
    pledge "goal"
  end
end
