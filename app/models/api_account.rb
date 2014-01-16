class ApiAccount < ActiveRecord::Base
  belongs_to :user
  belongs_to :api
  has_many :goals
  validate :acceptable_user_id
  validate :acceptable_api_id
  #validate :acceptable_username
  # validates :api_username, presence: true
  # validates :api_id, presence: true

  def api_account_exists
    !ApiRequest.new(api_username, "github").github_error?
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

