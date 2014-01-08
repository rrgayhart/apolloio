require "test_helper"

class UserTest < ActiveSupport::TestCase

  def omniauth_hash
    {
      "uid" => "1234567890",
      "info" => {
      "name" => "appolo"
    },
      "credentials" => {
      "provider" => "twitter"
    }
  }
  end

  def test_from_omniauth_creates_user
    user = User.create! do |u|
      u.name = "jonmagic"
      u.uid      = "1234567890"
      u.provider = "twitter"
    end

    assert_equal user, User.from_omniauth(omniauth_hash)
  end

  def test_from_omniauth_finds_user_that_exists
    user = User.from_omniauth(omniauth_hash)

    assert_equal user, User.from_omniauth(omniauth_hash)
  end

end
