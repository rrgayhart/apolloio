class User < ActiveRecord::Base
  has_many :goals
  has_many :reminders
  has_many :api_accounts

  def self.from_omniauth(auth)
    where(auth.slice("provider", "uid")).first || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["nickname"]
    end
  end

  def has_api_account?
    self.api_accounts.any?
  end
end
