require 'spec_helper'

describe Post do
  before(:each) do
    @provider_role = Role.create(:name => "Provider")
    @contacts_role = Role.create(:name => "Contacts")
    @general_role = Role.create(:name => "General User")

    @user_provider = Factory.create(:user, {
        :email => "john@example.com",
        :first_name => "John",
        :last_name => "Doe",
        :roles => [@provider_role]
      })

    @user_contacts = Factory.create(:user, {
        :email => "melinda@example.com",
        :first_name => "Melinda",
        :last_name => "Dee",
        :roles => [@contacts_role]
      })

    @user_general = Factory.create(:user, {
        :email => "kim@example.com",
        :first_name => "Kimberly",
        :last_name => "McLeod",
        :roles => [@general_role]
      })

    @post = Post.new({
        :title => "Test first post",
        :description => "Test for content",
        :status => "Publish"
      })
  end

  it "can be instantiated" do
    Post.new.should be_an_instance_of(Post)
  end

  it "can be saved successfully" do
    @post.save
    @post.should be_persisted
  end

  it "can't be saved successfully" do
    @post.title = nil
    @post.save
    @post.errors.should_not == []
  end

  it "must have errors with title" do
    @post.title = nil
    @post.save
    @post.errors[:title].should == ["can't be blank"]
  end
  
  it "must have errors with status" do
    @post.status = nil
    @post.save
    @post.errors[:status].should == ["can't be blank"]
  end

  it "should have post with published status" do
    @post.save
    @post.is_published?.should == true
  end

  it "should return posts list wiht status published" do
    @post.save
    Post.published.should_not == []
  end

  it "should have slugged with title" do
    @post.save
    @post.slug.should == "test-first-post"
  end
  
end

# == Schema Information
#
# Table name: posts
#
#  id             :integer         not null, primary key
#  user_id        :integer
#  title          :string(255)
#  description    :text
#  status         :string(255)
#  total_comment  :integer
#  last_commented :datetime
#  created_at     :datetime
#  updated_at     :datetime
#

