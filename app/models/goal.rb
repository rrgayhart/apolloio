class Goal < ActiveRecord::Base
    # t.integer  "user_id"
    # t.integer  "target"
    # t.integer  "period"
    # t.string   "period_type" - can be months, days, weeks
    # t.date     "start_date"
    # t.datetime "created_at"
    # t.datetime "updated_at"
    # t.string   "pledge"
    # t.integer  "api_account_id"
    # t.boolean  "active",         default: true
  belongs_to :user
  belongs_to :api_account
  has_many :reminders

  validates_presence_of :user_id, :target, :period, :period_type, :pledge
  validate :acceptable_target
  validate :acceptable_period
  validates :period_type, inclusion: { in: %w(day days week weeks month months),
    message: "%{value} is not a valid size" }

  def acceptable_target
    if target == nil || target < 1
      errors.add(:target, "can't be less than 1")
    end
  end

  def acceptable_period
    if period == nil || period < 1
      errors.add(:period, "can't be less than 1")
    end
  end

  def provider
    self.api_account.api.provider
  end

end
