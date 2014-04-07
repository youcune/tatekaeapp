require 'spec_helper'

describe "forms/show" do
  before(:each) do
    @form = assign(:form, stub_model(Form,
      :str_id => "Str",
      :name => "Name",
      :email => "Email",
      :event_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Str/)
    rendered.should match(/Name/)
    rendered.should match(/Email/)
    rendered.should match(/1/)
  end
end
