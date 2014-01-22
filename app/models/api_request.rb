require 'faraday'
require 'json'

class ApiRequest

  attr_reader :username, :user_hash, :provider

  def initialize(user, provider, stub=nil)
    @username = user
    @provider = provider
    if stub
      @user_hash = stub
    elsif provider.downcase == "github"
      @user_hash = github_hash
    else
      @user_hash = {}
    end
  end

  def valid_username_exercism?
    Faraday.get("http://exercism.io/api/v1/stats/#{username}/nitpicks/2014/01").status == 200
  end

  def valid_username_duolingo?
    Faraday.get("http://www.duolingo.com/users/#{username}").status == 200
  end

  def github_hash
    url = "http://github-history.herokuapp.com/find/#{username}.json"
    response = Faraday.get(url)
    JSON.parse(response.body)
  end

  def get_streak
    user_hash["current_streak"] || error_message
  end

  def get_contributions_today
    user_hash["contributions_today"] || error_message
  end

  def get_days_without_contributions
    user_hash["days_without_contributions"] || error_message
  end

  def get_this_years_total_commits
    user_hash["commits_this_year"] || error_message
  end

  def get_days_this_year_with_contributions
    user_hash["days_this_year_with_contributions"] || error_message
  end

  def get_days_in_the_year
    user_hash["days_in_the_year"] || error_message
  end

  def get_percentage_days_commited_this_year
    user_hash["percentage_days_commited_this_year"] || error_message
  end

  def get_percentage_days_commited_known_history
    user_hash["percentage_days_commited_known_history"] || error_message
  end

  def github_error?
    user_hash["error"]
  end

private

  def error_message
    "#{username} is not a valid username with #{provider}"
  end

end
