require 'spec_helper'

describe "forms/new" do
  before(:each) do
    assign(:form, stub_model(Form,
      :str_id => "MyString",
      :name => "MyString",
      :email => "MyString",
      :event_id => 1
    ).as_new_record)
  end

  it "renders new form form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => forms_path, :method => "post" do
      assert_select "input#form_str_id", :name => "form[str_id]"
      assert_select "input#form_name", :name => "form[name]"
      assert_select "input#form_email", :name => "form[email]"
      assert_select "input#form_event_id", :name => "form[event_id]"
    end
  end
end
