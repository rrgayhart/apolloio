# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :api do
    provider "github"
  end

  factory :fitbit_api, class: Api do
    provider "fitbit"
  end

  factory :exercism_api, class: Api do
    provider "exercism"
  end
end
