class Reminder < ActiveRecord::Base

  belongs_to :user
  belongs_to :goal
  has_one :api_account, through: :goal
  has_one :api, through: :api_account
  after_create :set_start_date
  attr_accessor :add_email, :add_phone_number

  def render_time_deadline
    self.time_deadline
  end

  def render_day_name(day_number)
    #Date::DAYNAMES[day_number]
  end

  def render_month_name(month_number)
    #Date::MONTHNAMES[month_number]
  end

  def goal_render
    number = self.day_deadline || 0
    case self.goal.period_type
    when "weeks", "weekly"
     "Every #{render_day_name(number)}"
    when "months", "monthly"
      "#{number.ordinalize} of the month"
    when "day", "daily", "days"
     "Daily"
    when "yearly", "years"
      render_month_name(number)
    else
      number
    end
  end

  def target_met?
    progress = Progress.new(self.goal).result
    progress.to_i >= self.target
  end

  def daily?
    self.goal.period_type == "day"
  end

  def daily_target_met?
    daily? && target_met?
  end

  def period_of_time
    case self.time_deadline
    when "Morning" then 9
    when "Afternoon" then 14
    when "Evening" then 21
    end
  end

  def commitment_achieved?
    if daily? && (period_of_time >= Time.now.hour)
       daily_target_met?
    end
  end

  def set_start_date
    update(start_date: DateTime.now.to_date)
  end
end
