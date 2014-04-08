class Mailer < ActionMailer::Base
  default from: "from@example.com"

  def welcome_email(params)
  	@message = params[:message]
    mail(to: params[:to], subject: "#{@message.subject}")
  end


end
