class MessagesController < ApplicationController
  
  before_filter :authenticate_user!
  
  autocomplete :user, :email

  def index          
    @messages = Message.select('sender_id').joins(:message_recipients).where("message_recipients.recipient_id = ?", current_user.id).group('sender_id')
  end

  def new
    @message = Message.new
    respond_to do |format|
      format.js
    end
  end

  def create
    params[:message][:sender_id] = current_user.id
    @message = Message.new(params[:message])
    @message.message_recipients << MessageRecipient.new(params[:message_recipient])
    respond_to do |format|
      if @message.save
        mr = @message.message_recipients.last
        @message_recipients = MessageRecipient.find(:all,
          :include    => :message,
          :conditions => ["(message_recipients.recipient_id = ? AND messages.sender_id = ?) or (message_recipients.recipient_id = ? AND messages.sender_id = ?) ", mr.recipient_id, current_user.id, current_user.id, mr.recipient_id],
          :order      => "message_recipients.created_at ASC"
        )
        format.html { redirect_to(@message, :notice => 'Message snt') }
        format.js
      else
        format.html { render :action => "new" }
        format.js
      end
    end
  end

  def show
    @message_recipients = MessageRecipient.find(:all,
      :include    => :message,
      :conditions => ["(message_recipients.recipient_id = ? AND messages.sender_id = ?) or (message_recipients.recipient_id = ? AND messages.sender_id = ?) ", params[:id], current_user.id, current_user.id, params[:id]],
      :order      => "message_recipients.created_at ASC"
    )
    @message_recipients.each {|x| x.update_attribute(:status, "read") }
    respond_to do |format|
      format.js
    end
  end
  
  def search
    @user = Message.search(current_user.id,params["search_message"])
    respond_to do |format|
      format.js
    end
  end

  def notifications
    @user = MessageRecipient.get_unread(current_user.id)
    respond_to do |format|
      format.js {@user.to_json}
    end
  end


  def destroy
    message_recipients =  MessageRecipient.find(:all, :joins => :message, :conditions => ["recipient_id = ? AND messages.sender_id = ?", current_user.id,  params[:id]])
    message_recipients.each do |mr|
      mr.update_attribute(:status, "delete")
    end
    @user_id = params[:id]
    respond_to do |format|
      format.js
    end
  end
end
