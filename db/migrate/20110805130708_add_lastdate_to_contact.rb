class AddLastdateToContact < ActiveRecord::Migration
  def self.up
	add_column :contacts,:lastcommunicatedon,:date
  end

  def self.down
   remove_column :contacts, :lastcommunicatedon
  end
end
