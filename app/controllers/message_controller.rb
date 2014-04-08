#encoding: utf-8
class MessageController < ApplicationController

	 # GET /events/:event_str_id/message
  def new
  	@event = Event.find_by_str_id(params[:event_str_id])

  	to_arr = Array.new
  	@event.forms.each do |form|
  		to_arr.push form.email
  	end

  	@message = Message.new
  	@message.to_arr = to_arr.join(',')
  end

  # POST /events/:event_str_id/message
  def send_message
  	p params
    @message = Message.new(params[:message])
  	@event = Event.find_by_str_id(params[:event_str_id])
  	@event.forms.each do |form|
  		Mailer.welcome_email(message: @message, to: form.email).deliver
  	end
  end
end
