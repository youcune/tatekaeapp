require 'spec_helper'

describe "forms/index" do
  before(:each) do
    assign(:forms, [
      stub_model(Form,
        :str_id => "Str",
        :name => "Name",
        :email => "Email",
        :event_id => 1
      ),
      stub_model(Form,
        :str_id => "Str",
        :name => "Name",
        :email => "Email",
        :event_id => 1
      )
    ])
  end

  it "renders a list of forms" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Str".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
