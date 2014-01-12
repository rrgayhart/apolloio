class ApiAccount < ActiveRecord::Base
  belongs_to :user
  belongs_to :api
  has_many :goals
  validates :api_username, presence: true
end
