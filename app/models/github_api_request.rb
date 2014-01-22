require 'faraday'
require 'json'

class GithubApiRequest

  attr_reader :days_to_pull, :target, :username, :user_array

  def initialize(days_to_pull, target, username)
    @days_to_pull = days_to_pull
    @target = target
    @username = username
    @user_array = get_contributions_array(contribution_link)
  end

  def contribution_link
    "https://github.com/users/#{@username}/contributions_calendar_data"
  end

  def get_contributions_array(url)
    Rails.cache.fetch("github_#{username}", expires_in: 5.minutes) do
      response = Faraday.get(url)
      JSON.parse(response.body)
    end
  end

  def pull_dates
    @user_array.last(days_to_pull)
  end

  def pull_contribution_count(date_array)
    date_array.inject(0) {|sum, date| sum + date.last }
  end

  def progress
    contributions = pull_contribution_count(pull_dates)
    percentage = contributions.to_f / target.to_f * 100
    percentage.ceil.to_s
  end

  def get_count
    pull_contribution_count(pull_dates)
  end

end
