FactoryGirl.define do

  factory :user do
    provider "Twitter"
    uid  "1234"
    name  "johndoe"
  end

end
