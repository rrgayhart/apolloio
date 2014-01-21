class SmsNotifications

  def self.send_sms(user, reminder)
    @current_user = user
    @reminder     = reminder
    client        = Twilio::REST::Client.new(TWILIO_CONFIG['sid'], TWILIO_CONFIG['token'])
    client.account.sms.messages.create(
      from: TWILIO_CONFIG['from'],
      to: @current_user.phone_number,
      body: "A reminder was created. It will notify you via SMS the #{@reminder.time_deadline} of every #{@reminder.day_deadline} day if you haven't hit your #{@reminder.target} commit."
    )
  end
end
