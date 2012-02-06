class CreateConversations < ActiveRecord::Migration
  def self.up
    create_table :conversations do |t|
      t.integer :member_count
      t.timestamps
    end
  end

  def self.down
    drop_table :conversations
  end
end
