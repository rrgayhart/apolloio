class Reminder < ActiveRecord::Base
  
  # create_table "reminders", force: true do |t|
  #   t.integer  "user_id"
  #   t.integer  "goal_id"
  #   t.integer  "target" - What I need to be at in order to not receive a notification
  #   t.boolean  "twitter"
  #   t.boolean  "email"
  #   t.boolean  "sms"
  #   t.datetime "created_at"
  #   t.datetime "updated_at"
  #   t.integer  "day_deadline" - Day of the week or month for the notification
  #   t.time     "time_deadline" - Time of the day that I would get this notification
  #   t.date     "start_date" - Date for when this reminder system starts
  # end

  belongs_to :user
  belongs_to :goal
  has_one :api_account, through: :goal
  has_one :api, through: :api_account

  def render_day_name(day_number)
    Date::DAYNAMES[day_number]
  end

  def render_month_name(day_number)
    Date::MONTHNAMES[3]
  end

  def goal_render
    number = self.day_deadline
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
end
