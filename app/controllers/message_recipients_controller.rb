class MessageRecipientsController < ApplicationController
  def unread
    @message_recipient =  MessageRecipient.find(params[:id])
    @message_recipient.update_attribute(:status, "unread")
    respond_to do |format|
      format.js
    end
  end
end
