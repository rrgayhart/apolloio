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
  end

  def test_from_omniauth_finds_user_that_exists
    user = User.from_omniauth(omniauth_hash)
    assert_equal user, User.from_omniauth(omniauth_hash)
  end

  def test_a_user_has_no_api_accounts_if_its_api_accounts_are_empty
    user = User.new(api_accounts: [])

    assert(!user.has_api_account?)
  end

  def test_a_user_has_api_accounts_if_its_api_accounts_are_not_empty
    user = User.new(api_accounts: ['anything'])

    assert(user.has_api_account?)
  end


  #testing active record
  #testing the behaviour of associations
  #how an article determines what its user is
  #use mocks and stubs

end
