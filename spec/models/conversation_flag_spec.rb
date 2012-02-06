require 'spec_helper'

describe ConversationFlag do
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

    @conversation = Conversation.build_conversation(
      :recipient_tokens => "#{@user_provider.id}",
      :owner_id => "#{@user_contacts.id}",
      :body => "Test Message"
    )
  end


  it "can be instantiated" do
    ConversationFlag.new.should be_an_instance_of(ConversationFlag)
  end

  it "can be saved successfully" do
    @conversation.save
    @conversation.conversation_flags.first.should be_persisted
  end

  it "can't be saved successfully" do
    @conversation.recipient_tokens = nil
    @conversation.save
    @conversation.conversation_flags.first.should_not be_persisted
  end

  it "should have Unread status for recipient " do
    @conversation.save
    @conversation.conversation_flags.where("user_id = ?", @user_provider.id).first.status.should == "Unread"
  end
  
  it "should have Unread status for sender" do
    @conversation.save
    @conversation.conversation_flags.where("user_id = ?", @user_contacts.id).first.status.should == "Unread"
  end

end

# == Schema Information
#
# Table name: conversation_flags
#
#  id              :integer         not null, primary key
#  user_id         :integer
#  conversation_id :integer
#  status          :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

