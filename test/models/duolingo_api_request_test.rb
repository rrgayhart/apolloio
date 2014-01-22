require "test_helper"

class DuolingoApiTest < ActiveSupport::TestCase

  def setup
    VCR.use_cassette('duolingo_test1') do
      @request = DuolingoApiRequest.new("rrgayhart", "Spanish")
    end
  end

  def teardown
  end

  def test_it_gets_site_streak
    VCR.use_cassette('duolingo_test1') do
      assert_equal 0, @request.get_site_streak
    end
  end

  def test_it_gets_details_by_language
    VCR.use_cassette('duolingo_test1') do
      assert_equal ["streak", "language_string", "language", "level", "points", "learning", "current_learning", "sentences_translated"], @request.get_details_by_language[0].keys
      assert_equal 1, @request.get_details_by_language.count
      assert_equal 0, @request.get_streak
    end
  end

  def test_it_gets_streak_any_language
    VCR.use_cassette('duolingo_test2') do
      request2 = DuolingoApiRequest.new("rrgayhart", "Any Language")
      assert_equal 0, request2.get_streak
    end
  end

  def test_it_gets_progress
    VCR.use_cassette('duolingo_test1') do
      assert_equal "0", @request.progress
    end
  end

  def test_get_count
    VCR.use_cassette('duolingo_test1') do
      assert_equal 0, @request.get_count
    end
  end
end
