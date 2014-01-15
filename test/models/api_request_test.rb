require "test_helper"

class ApiRequestTest < ActiveSupport::TestCase

  def setup
    @stub = {"username" => "adam89","contributions_today" => 1,"current_streak" => 34,"days_without_contributions" => 248,"days_this_year_with_contributions" => 14, "days_in_the_year" => 15,"percentage_days_commited_this_year" => 0.9333333333333333,"percentage_days_commited_known_history" => 0.3224043715846995}
  end

  def test_get_streak
    user = "adam89"
    ai = ApiRequest.new(user, "github", @stub)
    assert_equal 34, ai.get_streak
  end

  def test_get_error_for_invalid_user
    user = "adamasdfcueahg89"
    ai = ApiRequest.new(user, "github")
    assert_equal "INVALID USERNAME", ai.get_streak
  end
end
