# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :api_account do
    # association :user
    # association :api
    user 
    api
    api_username 'jonahmoses'
  end
end
