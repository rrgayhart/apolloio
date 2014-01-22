# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :api do
    provider {"api"}
    
    trait :github do
      provider "Github"
    end

    trait :fitbit do
      provider "Fitbit"
    end

    trait :exercism do
      provider "Exercism"
    end
  end
end
