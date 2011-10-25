class ConversationsController < ApplicationController

  before_filter :authenticate_user!
  
  def index
    @conversations = Conversation.includes(:users, :conversation_flags).
      where("users.id = ? AND conversation_flags.status <> ? AND conversation_flags.user_id = ?", current_user.id, "Archive", current_user.id).
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
    @users = User.where("(first_name||' '|| last_name) ILIKE ? AND id <> ?", "%#{params[:q]}%", current_user.id)
    respond_to do |format|
      format.html
      format.json { render :json => @users.map{|user| user.attributes.merge(:full_name => user.full_name) } }
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
    @messages =  MessageConversation.included_me(@conversation, current_user)
    @messages = @messages.sort {|x,y| x.created_at <=> y.created_at }
    @conversation.mark_as_read(current_user)
  end

  def update
    @conversation = Conversation.find(params[:id])
    @conversation.update_conversation_with_reply(params[:conversation])
    @message = @conversation.last_message
  end

  def notifications
    @inbox = Conversation.my_inbox(current_user)
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
    @conversation.mark_as_archive(current_user)
  end

  def search_conversations_by_name
    @conversations = Conversation.by_name(params[:q])
    @conversations.select{|c| c.users.include?(current_user)}
    respond_to do |format|
      format.html
      format.json {
        render :json => @conversations.map{|conv|
          conv.attributes.merge({:title => conversation_title(conv), :last_message => conv.messages.last.body})
        }
      }
    end  
  end

  
end
