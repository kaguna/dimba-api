# Download the twilio-ruby library from twilio.com/docs/libraries/ruby
require 'twilio-ruby'
module SMS
  def send_sms
    account_sid = 'ACd4dcfe50269cddaa624459b6fc193b9b'
    auth_token = 'e4cb1125795f5a5c440e6b4e6a433de0'
    client = Twilio::REST::Client.new(account_sid, auth_token)

    from = '+15005550006' # Your Twilio number
    to = '+2540101940739' # Your mobile phone number

    message = client.messages.create(
    from: from,
    to: to,
    body: "Thank for creating an account with us. Kindly visit https://cheza-dimba.herokuapp.com/ for more fun."
    )
    puts message.sid, "%%%%%%%%%%%%%%%%%%%%%%%%%"
  end
end