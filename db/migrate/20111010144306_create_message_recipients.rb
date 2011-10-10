class CreateMessageRecipients < ActiveRecord::Migration
  def self.up
    create_table :message_recipients do |t|
      t.integer :message_id, :null => false
      t.integer :recipient_id, :null => false
      t.string :status, :limit => 10
        
      t.timestamps
    end
    add_index :message_recipients, :message_id
    add_index :message_recipients, :recipient_id
  end

  def self.down
    drop_table :message_recipients
  end
end
