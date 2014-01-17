require "test_helper"

class GithubApiTest < ActiveSupport::TestCase

  def setup
    VCR.use_cassette('hartl_history') do
      @request = GithubApiRequest.new(1, 5, "mhartl")
    end
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

  def test_progress_normal_progress
    VCR.use_cassette('hartl_history2') do
      assert_equal "80", @request.progress
    end
  end

  def test_progress_at_100_percent
    VCR.use_cassette('hartl_history3') do
      request2 = GithubApiRequest.new(2, 6, "mhartl")
      assert_equal "100", request2.progress
    end
  end

  def test_progress_at_over_100_percent
    VCR.use_cassette('hartl_history4') do
      request3 = GithubApiRequest.new(3, 5, "mhartl")
      assert_equal "140", request3.progress
    end
  end

  def test_progress_at_uneven_number 
    VCR.use_cassette('hartl_history5') do
      request4 = GithubApiRequest.new(3, 9, "mhartl")
      assert_equal "78", request4.progress
    end
  end
end
