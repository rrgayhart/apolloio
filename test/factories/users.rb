FactoryGirl.define do

  factory :user do
    provider "twitter"
    uid  "1234"
    name  "johndoe"
  end

end
