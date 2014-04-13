require 'spec_helper'

describe "fopt_masters/index" do
  before(:each) do
    assign(:fopt_masters, [
      stub_model(FoptMaster,
        :event_id => 1,
        :order => 2,
        :name => "Name",
        :value_type => "Value Type",
        :choices => "Choices"
      ),
      stub_model(FoptMaster,
        :event_id => 1,
        :order => 2,
        :name => "Name",
        :value_type => "Value Type",
        :choices => "Choices"
      )
    ])
  end

  it "renders a list of fopt_masters" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Value Type".to_s, :count => 2
    assert_select "tr>td", :text => "Choices".to_s, :count => 2
  end
end
