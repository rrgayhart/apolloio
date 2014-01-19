class Reminder < ActiveRecord::Base

  belongs_to :user
  belongs_to :goal
  has_one :api_account, through: :goal
  has_one :api, through: :api_account
  after_create :set_start_date
  attr_accessor :add_email

  def render_time_deadline
    time = self.time_deadline
    if time.class == Time
      time.strftime("%T")
    end
  end

  def render_day_name(day_number)
    Date::DAYNAMES[day_number]
  end

  def render_month_name(day_number)
    Date::MONTHNAMES[3]
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

  def set_start_date
    update(start_date: DateTime.now.to_date)
  end
end
