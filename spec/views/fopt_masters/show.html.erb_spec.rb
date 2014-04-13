require 'spec_helper'

describe "fopt_masters/show" do
  before(:each) do
    @fopt_master = assign(:fopt_master, stub_model(FoptMaster,
      :event_id => 1,
      :order => 2,
      :name => "Name",
      :value_type => "Value Type",
      :choices => "Choices"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Name/)
    rendered.should match(/Value Type/)
    rendered.should match(/Choices/)
  end
end
