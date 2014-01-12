require "test_helper"

class ApiAccountTest < ActiveSupport::TestCase
  def test_valid_user_checks_for_valid_github_username
    thehub = FactoryGirl.create(:api_account)
    assert_equal true, thehub.is_valid_user?
  end

  def test_valid_user_checks_for_invalid_github_username
    thehub = FactoryGirl.create(:api_account, api_username: "afnsuurgauhsfuhaegas")
    assert_equal false, thehub.is_valid_user?
  end

  # def test_valid_user_checks_for_invalid_exercism_username
  # end

  # def test_valid_user_checks_for_invalid_fitbit_username
  # end
end
