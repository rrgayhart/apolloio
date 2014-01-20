require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  test "reminder_confirmation" do
    @user = FactoryGirl.create(:user)
    mail = UserMailer.reminder_confirmation(@user)
    assert_equal "New Reminder Confirmation", mail.subject
    assert_equal ["from@example.com"], mail.from
  end

end