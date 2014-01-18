class Goal < ActiveRecord::Base
  belongs_to :user
  belongs_to :api_account
  has_many :reminders
  after_create :set_time

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

  def set_time
    update(start_date: DateTime.now)
  end

end
