class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages, :force => true do |t|
      t.integer :sender_id, :null => false
      t.integer :recipient_id, :null => false
      t.integer :body, :null => false
      t.string :status

      t.timestamps
    end
    
    add_index :messages, :sender_id
    add_index :messages, :recipient_id
    add_index :messages, :body
    
  end

  def self.down
    drop_table :messages
  end
end
