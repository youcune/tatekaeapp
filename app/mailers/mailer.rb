class Mailer < ActionMailer::Base
  default from: "from@example.com"

  def welcome_email(message)
  	@message = message
    mail(to: "majackyy@gmail.com", subject: "#{@message.subject}")
  end
end
