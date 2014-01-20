class Progress

attr_reader :goal

  def initialize(goal)
    @goal = goal
  end

  def result
    prepare_api_request
  end

  def prepare_api_request
    case goal.provider.downcase
    when "github"
      github_preparation
    when "exercism"
      exercism_preparation
    when "fitbit"
      "Fitbit not prepared yet"
    else
     "invalid provider"
    end
  end

  def exercism_preparation
    request = ExercismApiRequest.new(days_to_pull, goal.target, goal.api_account.api_username, goal.commit_type, goal.language)
    request.progress
  end

  def github_preparation
    github_request(days_to_pull, goal.target)
  end

  def github_request(days_to_pull, target)
    username = goal.api_account.api_username
    request = GithubApiRequest.new(days_to_pull, target, username)
    request.progress
  end

  def days_to_pull
    case goal.period_type
    when "day", "days"
      goal.period
    when "week", "weeks"
      less_one = goal.period - 1
      days = less_one * 7
      weekday = Date.today.wday + 1
      days + weekday
    when "month", "months"
      start = Date.today << (goal.period - 1)
      previous = Date.today - start
      previous + Date.today.mday
    end
  end

end
