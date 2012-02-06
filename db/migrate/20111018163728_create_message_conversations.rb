class CreateMessageConversations < ActiveRecord::Migration
  def self.up
    create_table :message_conversations do |t|
      t.integer :conversation_id, :null => false
      t.integer :sender_id, :null => false
      t.integer :recipient_id, :null => false
      t.text :body, :null => false
      t.string :status_for_sender
      t.string :status_for_recipient
      t.timestamps
    end
    add_index :message_conversations, :conversation_id
    add_index :message_conversations, :sender_id
    add_index :message_conversations, :recipient_id
    add_index :message_conversations, :body
    add_index :message_conversations, :status_for_sender
    add_index :message_conversations, :status_for_recipient
  end

  def self.down
    drop_table :message_conversations
  end
end
