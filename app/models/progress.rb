class Progress

attr_reader :goal

  def initialize(goal)
    @goal = goal
  end

  def result
    prepare_api_request.progress
  end

  def count_to_complete
    goal.target - get_count
  end

  def get_count
    prepare_api_request.get_count
  end

  def prepare_api_request
    case goal.provider.downcase
    when "github"
      github_preparation
    when "exercism"
      exercism_preparation
    when "duolingo"
      duolingo_preparation
    else
     "invalid provider"
    end
  end

  def duolingo_preparation
    DuolingoApiRequest.new(goal.api_account.api_username, goal.language)
  end

  def exercism_preparation
    ExercismApiRequest.new(days_to_pull, goal.target, goal.api_account.api_username, goal.commit_type, goal.language)
  end

  def github_preparation
    github_request(days_to_pull, goal.target)
  end

  def github_request(days_to_pull, target)
    username = goal.api_account.api_username
    request = GithubApiRequest.new(days_to_pull, target, username)
  end

  def days_to_pull
    case goal.period_type
    when "day", "days", "daily"
      1
    when "week", "weeks", "weekly"
      Date.today.wday + 1
    when "month", "months", "monthly"
      Date.today.mday
    when "year", "years", "yearly"
      Date.today.yday
    end
  end

  def time_left
    date1 = Time.now
    date2 = Time.now.at_end_of_day
    hours = ((date2 - date1) / 1.hour).round
    week_days = 6 - Date.today.wday
    days = Date.today.end_of_month.mday - Date.today.mday - 1
    months = 12 - Date.today.month
    case goal.period_type
    when "day", "days", "daily"
      "#{hours} hours"
    when "week", "weeks", "weekly"
      "#{week_days} days and #{hours} hours"
    when "month", "months", "monthly"
      "#{days} days and #{hours} hours"
    when "year", "years", "yearly"
      "#{months} months #{days} days and #{hours} hours"
    end
  end

end
