# encoding: utf-8
require 'spec_helper'

describe "Events" do
  describe "GET /events" do
    it "works! (now write some real specs)" do
      visit '/events'
      page.should have_content('イベント新規作成')
    end
  end
end
