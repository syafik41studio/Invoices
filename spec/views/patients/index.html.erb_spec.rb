require 'spec_helper'

describe "patients/index.html.erb" do
  before(:each) do
    assign(:patients, [
      stub_model(Patient,
        :user_id => 1,
        :name => "Name",
        :age => 1.5,
        :description => "MyText",
        :primary_contact => "Primary Contact",
        :relation => "Relation",
        :email => "Email",
        :phone_number => "Phone Number",
        :city => "City",
        :state => "State"
      ),
      stub_model(Patient,
        :user_id => 1,
        :name => "Name",
        :age => 1.5,
        :description => "MyText",
        :primary_contact => "Primary Contact",
        :relation => "Relation",
        :email => "Email",
        :phone_number => "Phone Number",
        :city => "City",
        :state => "State"
      )
    ])
  end

  it "renders a list of patients" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Primary Contact".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Relation".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Phone Number".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "City".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "State".to_s, :count => 2
  end
end
