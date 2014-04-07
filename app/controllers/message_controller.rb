#encoding: utf-8
class MessageController < ApplicationController
  def new
  	@message = Message.new
  end

  def send_message
    @message = Message.new(params[:message])
    Mailer.welcome_email(@message).deliver
  end
end
