class ConversationsController < ApplicationController

  before_filter :authenticate_user!
  
  def index
    @conversations = Conversation.includes(:users).
      where("users.id = ?",current_user.id).
      order("conversations.updated_at DESC")
  end

  def new
    @conversation = Conversation.new
    @users = []
    respond_to do |format|
      format.js
    end
  end

  def user_token_input
    @users = User.where("email like ? AND id <> ?", "%#{params[:q]}%", current_user.id)
    respond_to do |format|
      format.html
      format.json { render :json => @users.map(&:attributes) }
    end  
  end

  def create
    @conversation = Conversation.build_conversation(params[:conversation])
    if @conversation.save
      render :update do |page|
        page.redirect_to conversation_path(@conversation)
      end
    end
  end

  def show
    @conversation = Conversation.find(params[:id])
    @messages =  MessageConversation.included_me(@conversation, current_user).recent
    @conversation.mark_as_read(current_user)
  end

  def update
    @conversation = Conversation.find(params[:id])
    @conversation.update_conversation_with_reply(params[:conversation])
    @message = @conversation.last_message
  end

  def notifications
    @inbox = MessageConversation.my_inbox(current_user)
    respond_to do |format|
      format.js {@inbox.to_json}
    end
  end

  def mark_as_read
    @conversation = Conversation.find(params[:id])
    @conversation.mark_as_read(current_user)
  end

  def mark_as_unread
    @conversation = Conversation.find(params[:id])
    @conversation.mark_as_unread(current_user)
  end

  def archive
    @conversation = Conversation.find(params[:id])
    MessageConversation.update_all("status_for_recipient = 'Unread'",
      "conversation_id = #{@conversation.id} AND status_for_recipient = 'Read' AND id = #{@conversation.messages.last.id}")
  end

  
end
