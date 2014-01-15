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
    if user_array["error"]
      user_array["error"]
    else
      user_array["current_streak"]
    end
  end

end
