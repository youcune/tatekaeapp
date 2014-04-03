class SessionsController < ApplicationController
  def create
  	puts "env"
  	request.env.each do |key,value|
  		puts "#{key} = #{value}"
  	end
  	puts "amniauth.auth"
  	p request.env["omniauth.auth"] 
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    p user

    session[:user_id] = user.id
    redirect_to root_url, :notice => "Signed In!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed Out!"
  end
end