require 'spec_helper'

describe "patients/show.html.erb" do
  before(:each) do
    @patient = assign(:patient, stub_model(Patient,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1.5/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Primary Contact/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Relation/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Email/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Phone Number/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/City/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/State/)
  end
end
