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

  def test_progress_functions
    Timecop.freeze("2014-01-20 15:35:02 -0700".to_time) do
    VCR.use_cassette('rrgayhart1', :record => :new_episodes) do
      @submissions = ExercismApiRequest.new(25, 5, "rrgayhart", "submission", "ruby")
      assert_equal '100', @submissions.progress
    end
  end
  end

  def test_valid_exercism_name
    VCR.use_cassette('invalic_checks', :record => :new_episodes) do
      refute ExercismApiRequest.valid_username?('sdfefsf')
      assert ExercismApiRequest.valid_username?('thewatts')
    end
  end

  def test_which_dates_returns_accurate_dates
    VCR.use_cassette('which_dates_calls', :record => :new_episodes) do
      Timecop.freeze("2014-01-20 15:35:02 -0700".to_time) do
        request1 = ExercismApiRequest.new(1, 1, "thewatts", "submission", "ruby")
        assert_equal ["2014/01"], request1.which_dates
        request2 = ExercismApiRequest.new(20, 1, "thewatts", "submission", "ruby")
        assert_equal ["2013/12", "2014/01"], request2.which_dates
        request3 = ExercismApiRequest.new(100, 1, "thewatts", "submission", "ruby")
        assert_equal ["2013/10", "2013/11", "2013/12", "2014/01"], request3.which_dates
      end
    end
  end

  def test_which_links_returns_correct_links
    VCR.use_cassette('kytrinyx_nitpick', :record => :new_episodes) do
      Timecop.freeze("2014-01-20 15:35:02 -0700".to_time) do
        correct_link = ["http://exercism.io/api/v1/stats/kytrinyx/nitpicks/2014/01"]
        assert_equal correct_link, @nitpicks.which_links(["2014/01"])
        multiple_links = ["http://exercism.io/api/v1/stats/kytrinyx/nitpicks/2013/10",
                         "http://exercism.io/api/v1/stats/kytrinyx/nitpicks/2013/11", 
                         "http://exercism.io/api/v1/stats/kytrinyx/nitpicks/2013/12", 
                         "http://exercism.io/api/v1/stats/kytrinyx/nitpicks/2014/01"]
        assert_equal multiple_links, @nitpicks.which_links(["2013/10", "2013/11", "2013/12", "2014/01"])
      end
    end
  end

  def test_start_date_returns_correct_number
    Timecop.freeze("2014-01-20 15:35:02 -0700".to_time) do
      VCR.use_cassette('kytrinyx_nitpick', :record => :new_episodes) do
        nitpicks2 = ExercismApiRequest.new(4, 18, "kytrinyx", "nitpick", "ruby")
        assert_equal 4, nitpicks2.days_to_pull
        assert_equal '16 Jan 2014'.to_date, nitpicks2.start_date
      end
    end
  end

  def test_generate_hash_renders_correct_format
    Timecop.freeze("2014-01-20 15:35:02 -0700".to_time) do
      VCR.use_cassette('kytrinyx_nitpick', :record => :new_episodes) do
        languages = ["clojure", "coffeescript", "elixir", "go", "haskell", "javascript", "objective-c", "ocaml", "perl5", "python", "ruby", "scala"]
        assert_equal languages, @nitpicks.generate_hash.first.keys
        days_in_the_month = 31
        assert_equal 31, @nitpicks.generate_hash.first['clojure'].count
        months = 1
        assert_equal months, @nitpicks.generate_hash.count
      end
    end
  end

  def test_generate_hash_handles_multiple_months
    Timecop.freeze("2014-01-20 15:35:02 -0700".to_time) do
      VCR.use_cassette('kytrinyx_nitpick_large', :record => :new_episodes) do
        @nitpicks_large = ExercismApiRequest.new(20, 1, "kytrinyx", "nitpick", "ruby")
        months = 2
        assert_equal months, @nitpicks_large.generate_hash.count
      end
    end
  end

  def test_get_array_by_language_handles_one_language
    Timecop.freeze("2014-01-20 15:35:02 -0700".to_time) do  
      VCR.use_cassette('kytrinyx_nitpick_large', :record => :new_episodes) do
        nitpicks_large = ExercismApiRequest.new(20, 1, "kytrinyx", "nitpick", "ruby")
        clojure = nitpicks_large.get_array_by_language('clojure')
        ruby = nitpicks_large.get_array_by_language('ruby')
        refute_equal clojure, ruby
        assert_equal clojure.first['date'], ruby.first['date']
        refute_equal clojure.first['count'], ruby.first['count']
      end
    end
  end

  def test_get_array_by_any_language_functions
    Timecop.freeze("2014-01-20 15:35:02 -0700".to_time) do  
      VCR.use_cassette('kytrinyx_nitpick_large', :record => :new_episodes) do
        nitpicks_large = ExercismApiRequest.new(20, 1, "kytrinyx", "nitpick", 'any language')
        any_language = nitpicks_large.get_array_by_language('any language')
        assert_equal 240, any_language.count
        ruby = nitpicks_large.get_array_by_language('ruby')
        refute_equal any_language, ruby
        assert_equal any_language.first['date'], ruby.first['date']
        refute_equal any_language.first['count'], ruby.first['count']
      end
    end
  end
  def test_get_contribution_count_by_any_language_functions
    Timecop.freeze("2014-01-20 15:35:02 -0700".to_time) do      
      VCR.use_cassette('kytrinyx_nitpick', :record => :new_episodes) do
        any_language = @nitpicks.get_contribution_count_by_language('any language')
        ruby = @nitpicks.get_contribution_count_by_language('ruby')
        clojure = @nitpicks.get_contribution_count_by_language('clojure')
        assert_equal 44, any_language
        assert_equal 22, ruby
        assert_equal 0, clojure
      end
    end
  end
end
