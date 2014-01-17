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
      "Exercism not prepared yet"
    when "fitbit"
      "Fitbit not prepared yet"
    else
     "invalid provider"
    end
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
    when "days"
      1
    when "weeks"
      #method if we are using week from start date
      #days_past = Date.today - goal.start_date
      #days_past % 7
      #method of just day of the week
      Date.today.wday
    when "months"
      Date.today.mday
    end
  end

end
