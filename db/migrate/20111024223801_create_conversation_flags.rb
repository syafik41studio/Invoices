class CreateConversationFlags < ActiveRecord::Migration
  def self.up
    create_table :conversation_flags do |t|
      t.integer :user_id
      t.integer :conversation_id
      t.string :status

      t.timestamps
    end
    add_index :conversation_flags, :user_id
    add_index :conversation_flags, :conversation_id
    add_index :conversation_flags, :status
  end

  def self.down
    drop_table :conversation_flags
  end
end
