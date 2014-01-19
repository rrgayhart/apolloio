# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :reminder do
    user nil
    goal nil
    target 1
    day_deadline "5"
    twitter false
    email false
    sms false
  end
end
