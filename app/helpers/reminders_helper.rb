module RemindersHelper
  def display_reminder(type)
    type ? 'YES' : 'NO'
  end
end
