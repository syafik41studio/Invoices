class MessagesController < ApplicationController
  autocomplete :user, :email

  def index
    @messages = Message.all
  end

  def new
    @message = Message.new
    respond_to do |format|
      format.js
    end
  end

  def create  
    @message = Message.new(params[:message])
    @message.message_recipients << MessageRecipient.new(params[:message_recipient])
    respond_to do |format|
      if @message.save
        format.html { redirect_to(@message, :notice => 'Message snt') }
        format.js
      else
        format.html { render :action => "new" }
        format.js
      end
    end
  end

  
end
