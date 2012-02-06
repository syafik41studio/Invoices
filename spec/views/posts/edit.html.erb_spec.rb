require 'spec_helper'

describe "posts/edit.html.erb" do
  before(:each) do
    @post = assign(:post, stub_model(Post,
      :user_id => 1,
      :title => "MyString",
      :description => "MyText",
      :status => "MyString",
      :total_comment => 1
    ))
  end

  it "renders the edit post form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => posts_path(@post), :method => "post" do
      assert_select "input#post_user_id", :name => "post[user_id]"
      assert_select "input#post_title", :name => "post[title]"
      assert_select "textarea#post_description", :name => "post[description]"
      assert_select "input#post_status", :name => "post[status]"
      assert_select "input#post_total_comment", :name => "post[total_comment]"
    end
  end
end
