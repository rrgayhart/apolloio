class ApiAccount < ActiveRecord::Base
  belongs_to :user
  belongs_to :api
  has_many :goals
  validates :api_username, presence: true

  def is_valid_user?
    username = self.api_username.downcase
    case self.api.provider.downcase
    when "github"
      url = "https://github.com/#{username}"
      response = Faraday.get(url)
      response.status == 200
    else
      true
    end
  end
end
