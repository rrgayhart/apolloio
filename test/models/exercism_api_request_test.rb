require "test_helper"

class ExercismApiTest < ActiveSupport::TestCase

  def setup
    VCR.use_cassette('kytrinyx_nitpick', :record => :new_episodes) do
      @nitpicks = ExercismApiRequest.new(4, 18, "kytrinyx", "nitpick", "ruby")
      @submissions = ExercismApiRequest.new(1, 1, "thewatts", "submission", "ruby")
    end
  end

  def teardown
  end

  def test_valid_exercism_name
    VCR.use_cassette('invalic_checks', :record => :new_episodes) do
      invalid = ApiRequest.new('sdfefsf', 'exercism')
      refute invalid.valid_username_exercism?
      valid = ApiRequest.new('thewatts', 'exercism')
      assert valid.valid_username_exercism?
    end
  end

  # def test_formatted_link_functions
  #   VCR.use_cassette('kytrinyx_nitpick', :record => :new_episodes) do
  #   assert_equal "boo",  @nitpicks.valid_username?('fnauebubaf')

  #   end

  # def test_formatted_date
  #   VCR.use_cassette('kytrinyx_nitpick', :record => :new_episodes) do
  #     assert_equal "boo", @submissions.progress
  #   end
  # end

end
