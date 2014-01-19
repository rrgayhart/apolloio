class Goal < ActiveRecord::Base
  belongs_to :user
  belongs_to :api_account
  has_many :reminders
  after_create :set_start_date

  validates_presence_of :user_id, :target, :period, :period_type, :pledge
  validate :acceptable_target
  validate :acceptable_period
  validates :period_type, inclusion: { in: %w(day days week weeks month months),
    message: "%{value} is not a valid size" }


  def valid_languages
    ["clojure", "coffeescript", "elixir", "go", "haskell", "javascript", "objective-c", "ocaml", "perl5", "python", "ruby", "scala"] 
  end

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

  def set_start_date
    update(start_date: DateTime.now.to_date)
  end

end
