require "test_helper"

class GithubApiTest < ActiveSupport::TestCase

  def setup
    @request = GithubApiRequest.new(1, 5, "mhartl")
  end

  def teardown
  end
  
  def test_contribution_link_formats_username
    assert_equal @request.contribution_link, "https://github.com/users/mhartl/contributions_calendar_data"
  end

  def test_pull_dates_returns_todays_contributions
    assert_equal Date.today, @request.pull_dates.last[0].to_date
  end

  def test_pull_contribution_count_returns_contribution_count
    assert_equal 6, @request.pull_contribution_count([["2014/01/14",1],["2014/01/15",2],["2014/01/16",3]])
  end

  def test_progress_prepares_the_progress_data
    assert_equal "60", @request.progress
    request2 = GithubApiRequest.new(2, 5, "mhartl")
    assert_equal "100", request2.progress
    request3 = GithubApiRequest.new(3, 5, "mhartl")
    assert_equal "120", request3.progress
    request4 = GithubApiRequest.new(3, 9, "mhartl")
    assert_equal "67", request4.progress
  end
end
