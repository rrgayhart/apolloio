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
      User.create do |u|
      u.name     = "Adam"
      u.uid      = "1234567890"
      u.provider = "twitter"
    end
  end

  def test_from_omniauth_finds_user_that_exists
    user = User.from_omniauth(omniauth_hash)
    assert_equal user, User.from_omniauth(omniauth_hash)
  end


  #testing active record
  #testing the behaviour of associations
  #how an article determines what its user is
  #use mocks and stubs

end
