require 'spec_helper'

describe "fopt_masters/new" do
  before(:each) do
    assign(:fopt_master, stub_model(FoptMaster,
      :event_id => 1,
      :order => 1,
      :name => "MyString",
      :value_type => "MyString",
      :choices => "MyString"
    ).as_new_record)
  end

  it "renders new fopt_master form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => fopt_masters_path, :method => "post" do
      assert_select "input#fopt_master_event_id", :name => "fopt_master[event_id]"
      assert_select "input#fopt_master_order", :name => "fopt_master[order]"
      assert_select "input#fopt_master_name", :name => "fopt_master[name]"
      assert_select "input#fopt_master_value_type", :name => "fopt_master[value_type]"
      assert_select "input#fopt_master_choices", :name => "fopt_master[choices]"
    end
  end
end
