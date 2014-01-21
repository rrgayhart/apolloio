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
    assert_equal "Tue, 21 Jan 2014".to_date, @request.pull_dates.last[0].to_date
  end

  def test_pull_contribution_count_returns_contribution_count
    assert_equal 6, @request.pull_contribution_count([["2014/01/14",1],["2014/01/15",2],["2014/01/16",3]])
  end

  def test_progress_normal_progress
    Timecop.freeze("2014-01-20 15:35:02 -0700".to_time) do
    VCR.use_cassette('hartl_history2') do
      assert_equal "0", @request.progress
    end
  end
  end

  def test_progress_at_100_percent
    Timecop.freeze("2014-01-20 15:35:02 -0700".to_time) do
    VCR.use_cassette('hartl_history3') do
      request2 = GithubApiRequest.new(9, 9, "mhartl")
      assert_equal "100", request2.progress
    end
    end
  end

  def test_progress_at_over_100_percent
    Timecop.freeze("2014-01-20 15:35:02 -0700".to_time) do
      VCR.use_cassette('hartl_history4') do
        request3 = GithubApiRequest.new(10, 5, "mhartl")
        assert_equal "200", request3.progress
      end
    end
  end

  def test_progress_at_uneven_number 
    Timecop.freeze("2014-01-20 15:35:02 -0700".to_time) do
    VCR.use_cassette('hartl_history5') do
      request4 = GithubApiRequest.new(3, 9, "mhartl")
      assert_equal "0", request4.progress
    end
  end
  end
end
