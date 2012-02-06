class AddMessageTokenToMessageConversations < ActiveRecord::Migration
  def self.up
    add_column :message_conversations, :message_token, :string
    add_index :message_conversations, :message_token
  end

  def self.down
    remove_column :message_conversations, :message_token
  end
end
