class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.integer :sender_id, :null => false
      t.text :message
      t.string :status, :limit => 10
      t.timestamps
    end
    add_index :messages, :sender_id
    add_index :messages, :message
    add_index :messages, :status
  end

  def self.down
    drop_table :messages
  end
end
