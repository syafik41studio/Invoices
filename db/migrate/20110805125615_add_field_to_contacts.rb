class AddFieldToContacts < ActiveRecord::Migration
  def self.up	
	add_column :contacts,:relatedas,:string
  end

  def self.down
	remove_column :contacts, :relatedas
  end
end
