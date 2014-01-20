class Goal < ActiveRecord::Base
  belongs_to :user
  belongs_to :api_account
  has_many :reminders
  after_create :set_start_date
  validates_presence_of :user_id, :target, :period_type, :pledge
  validate :acceptable_target
  validates :period_type, inclusion: { in: %w(day days daily week weeks weekly month months monthly year years yearly),
    message: "%{value} is not a valid size" }


  def valid_languages
    ["clojure", "coffeescript", "elixir", "go", "haskell", "javascript", "objective-c", "ocaml", "perl5", "python", "ruby", "scala", "any language"] 
  end

  def acceptable_target
    if target == nil || target < 1
      errors.add(:target, "can't be less than 1")
    end
  end

  def provider
    self.api_account.api.provider
  end

  def get_commit_type
    if self.commit_type
    self.commit_type.capitalize.pluralize 
    else
    "Commits"
  end
  end

  def set_start_date
    update(start_date: DateTime.now.to_date)
  end

end
