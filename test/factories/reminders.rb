# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :reminder do
    user nil
    goal nil
    target 1
    deadline "2014-01-08 21:59:09"
    twitter false
    email false
    sms false
  end
end
