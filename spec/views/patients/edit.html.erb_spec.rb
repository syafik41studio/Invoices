require 'spec_helper'

describe "patients/edit.html.erb" do
  before(:each) do
    @patient = assign(:patient, stub_model(Patient,
      :user_id => 1,
      :name => "MyString",
      :age => 1.5,
      :description => "MyText",
      :primary_contact => "MyString",
      :relation => "MyString",
      :email => "MyString",
      :phone_number => "MyString",
      :city => "MyString",
      :state => "MyString"
    ))
  end

  it "renders the edit patient form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => patients_path(@patient), :method => "post" do
      assert_select "input#patient_user_id", :name => "patient[user_id]"
      assert_select "input#patient_name", :name => "patient[name]"
      assert_select "input#patient_age", :name => "patient[age]"
      assert_select "textarea#patient_description", :name => "patient[description]"
      assert_select "input#patient_primary_contact", :name => "patient[primary_contact]"
      assert_select "input#patient_relation", :name => "patient[relation]"
      assert_select "input#patient_email", :name => "patient[email]"
      assert_select "input#patient_phone_number", :name => "patient[phone_number]"
      assert_select "input#patient_city", :name => "patient[city]"
      assert_select "input#patient_state", :name => "patient[state]"
    end
  end
end
