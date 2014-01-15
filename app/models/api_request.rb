require 'faraday'
require 'json'

class ApiRequest

  attr_reader :username, :user_array

  def initialize(user, provider, stub=nil)
    @username = user
    if stub
      @user_array = stub
    elsif provider.downcase == "github"
      @user_array = github_array
    end
  end

  def github_array
    url = "http://github-history.herokuapp.com/find/#{username}.json"
    response = Faraday.get(url)
    JSON.parse(response.body)
  end

  def get_streak
    user_array["current_streak"] || error_message
  end

  def get_contributions_today
    user_array["contributions_today"] || error_message
  end

  def get_days_without_contributions
    user_array["days_without_contributions"] || error_message
  end

  def get_days_this_year_with_contributions
    user_array["days_this_year_with_contributions"] || error_message
  end

  def get_days_in_the_year
    user_array["days_in_the_year"] || error_message
  end

  def get_percentage_days_commited_this_year
    user_array["percentage_days_commited_this_year"] || error_message
  end

  def get_percentage_days_commited_known_history
    user_array["percentage_days_commited_known_history"] || error_message
  end

  private

  def github_error?
    user_array["error"]
  end

  def error_message
    "#{username} is invalid"
  end

end
