require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the ConversationsHelper. For example:
#
# describe ConversationsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe ConversationsHelper do
  before(:each) do
    @user_admin = Factory.create(:user)
    @user_recipient = Factory.create(:user, {
        :email => "recipient@email.com",
        :first_name => "Recipient",
        :last_name => "Recipient"
      })
    @user_sender = Factory.create(:user, {
        :email => "sender@email.com",
        :first_name => "Sender",
        :last_name => "Sender"
      })
    @conversation = Conversation.build_conversation(
      :recipient_tokens => "#{@user_recipient.id}",
      :owner_id => "#{@user_sender.id}",
      :body => "Test Message"
    )
  end

  it "should show time with ago" do
    @conversation.save
    custom_time(@conversation.updated_at).should  == "less than a minute ago"
  end
  
end
