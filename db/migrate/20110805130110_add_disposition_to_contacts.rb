class AddDispositionToContacts < ActiveRecord::Migration
  def self.up
	add_column :contacts,:disposition,:string
  end

  def self.down
   remove_column :contacts, :disposition
  end
end
