class ApiAccount < ActiveRecord::Base
  belongs_to :user
  belongs_to :api
  has_many :goals
  validate :acceptable_user_id
  validate :acceptable_api_id
  # validate :acceptable_username, uniqueness: true

  def streak
    case self.api.provider.downcase
    when 'duolingo'
      response = DuolingoApiRequest.new(self.api_username, 'any language')
      response.get_site_streak
    when 'github'
      response = ApiRequest.new(self.api_username, 'github')
      response.get_streak
    when 'exercism'
    end
  end

  def api_account_exists
    case self.api.provider.downcase
    when 'github'
      !ApiRequest.new(api_username, "github").github_error?
    when 'exercism'
      ApiRequest.new(api_username, "exercism").valid_username_exercism?
    when 'duolingo'
      ApiRequest.new(api_username, "duolingo").valid_username_duolingo?
    end
  end

  def acceptable_username
    unless api_account_exists
      errors.add(:user, "API doesn't exist")
    end
  end

  def acceptable_api_id
    unless Api.find_by(id: api_id)
      errors.add(:api_id, "API ID doesn't exist")
    end
  end

  def acceptable_user_id
    unless User.find_by(id: user_id)
      errors.add(:user_id, "User doesn't exist")
    end
  end

end

