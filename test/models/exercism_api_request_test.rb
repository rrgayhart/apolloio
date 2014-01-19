require "test_helper"

class ExercismApiTest < ActiveSupport::TestCase

  def setup
    VCR.use_cassette('thewatts_submissions', :record => :new_episodes) do
      @submissions = ExercismApiRequest.new(1, 5, "thewatts", "submissions")
    end
    VCR.use_cassette('kytrinyx_nitpicks3', :record => :new_episodes) do
      @nitpicks = ExercismApiRequest.new(4, 1, "kytrinyx", "nitpicks")
    end
  end

  def teardown
  end

  def test_which_date
    VCR.use_cassette('kytrinyx_nitpicks2', :record => :new_episodes) do
      assert_equal "boo", @nitpicks.get_by_language('ruby')
    end
  end

end
