require "test_helper"

class UserTest < ActiveSupport::TestCase

  def omniauth_hash
    {
      "uid" => "1234567890",
      "provider" => "twitter",
      "info" => {
      "name" => "appolo"
    }
  }
  end

  def test_from_omniauth_creates_user
    user = User.create do |u|
      u.name     = "Adam"
      u.uid      = "1234567890"
      u.provider = "twitter"
    end

    assert_equal user, User.from_omniauth(omniauth_hash)
  end
   
  def test_from_omniauth_finds_user_that_exists
    user = User.from_omniauth(omniauth_hash)

    assert_equal user, User.from_omniauth(omniauth_hash)
  end

  def test_user_has_api_account_method_returns_true
    user = FactoryGirl.create(:user)
    assert_equal false, user.has_api_account?
    FactoryGirl.create(:api_account, user: user)
    assert_equal true, user.has_api_account?
  end

end
