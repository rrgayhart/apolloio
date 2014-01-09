class Reminder < ActiveRecord::Base
  belongs_to :user
  belongs_to :goal
  has_one :api_account, through: :goal
  has_one :api, through: :api_account
end
