require "test_helper"

class ExercismApiTest < ActiveSupport::TestCase

  def setup
    VCR.use_cassette('thewatts_submissions', :record => :new_episodes) do
      @submissions = ExercismApiRequest.new(1, 5, "thewatts", "submissions", "ruby")
    end
    VCR.use_cassette('kytrinyx_nitpicks3', :record => :new_episodes) do
      @nitpicks = ExercismApiRequest.new(4, 18, "kytrinyx", "nitpicks", "ruby")
    end
  end

  def teardown
  end

  def test_which_date
    VCR.use_cassette('kytrinyx_nitpicks2', :record => :new_episodes) do
      assert_equal "boo", @nitpicks.progress
    end
  end

end
