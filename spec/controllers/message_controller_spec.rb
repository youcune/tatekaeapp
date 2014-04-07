require 'spec_helper'

describe MessageController do

  describe "GET 'new_mail'" do
    it "returns http success" do
      get 'new_mail'
      response.should be_success
    end
  end

  describe "GET 'send_mail'" do
    it "returns http success" do
      get 'send_mail'
      response.should be_success
    end
  end

end
