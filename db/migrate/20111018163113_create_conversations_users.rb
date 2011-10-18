class CreateConversationsUsers < ActiveRecord::Migration
  def self.up
    create_table :conversations_users, :id => false do |t|
      t.integer :conversation_id
      t.integer :user_id
    end
  end

  def self.down
    drop_table :conversations_users
  end
end
