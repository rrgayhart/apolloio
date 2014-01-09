class ApiAccount < ActiveRecord::Base
  belongs_to :user
  belongs_to :api
  has_many :goals
end
