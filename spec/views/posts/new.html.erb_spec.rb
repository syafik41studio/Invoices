require 'spec_helper'

describe "posts/new.html.erb" do
  before(:each) do
    assign(:post, stub_model(Post,
      :user_id => 1,
      :title => "MyString",
      :description => "MyText",
      :status => "MyString",
      :total_comment => 1
    ).as_new_record)
  end

  it "renders new post form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => posts_path, :method => "post" do
      assert_select "input#post_user_id", :name => "post[user_id]"
      assert_select "input#post_title", :name => "post[title]"
      assert_select "textarea#post_description", :name => "post[description]"
      assert_select "input#post_status", :name => "post[status]"
      assert_select "input#post_total_comment", :name => "post[total_comment]"
    end
  end
end
