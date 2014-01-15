require "test_helper"

class ApiRequestTest < ActiveSupport::TestCase

  def setup
    @user
    @stub = {"username" => "adam89","contributions_today" => 1,"current_streak" => 38,"days_without_contributions" => 248,"days_this_year_with_contributions" => 14, "days_in_the_year" => 15,"percentage_days_commited_this_year" => 0.9333333333333333,"percentage_days_commited_known_history" => 0.3224043715846995}
    @api_request = ApiRequest.new(@user, "github", @stub)
  end

  def test_get_streak
    assert_equal 38, @api_request.get_streak
  end

  def test_get_error_for_invalid_user
    user = "adamasdfcueahg89"
    ai = ApiRequest.new(user, "github")
    assert_equal "adamasdfcueahg89 is invalid", ai.get_streak
  end

  def test_get_contributions_today
    assert_equal 1, @api_request.get_contributions_today
  end

  def test_get_days_without_contributions
    assert_equal 248, @api_request.get_days_without_contributions
  end

  def test_days_this_year_with_contributions
    assert_equal 14, @api_request.get_days_this_year_with_contributions
  end

  def test_days_in_the_year
    assert_equal 15, @api_request.get_days_in_the_year
  end

  def test_get_percentage_days_commited_this_year
    assert_equal 0.9333333333333333, @api_request.get_percentage_days_commited_this_year
  end

  def test_get_percentage_days_commited_known_history
    assert_equal 0.3224043715846995, @api_request.get_percentage_days_commited_known_history
  end
end
