class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.references :entity, :polymorphic => true
      t.string :firstname
      t.string :lastname
      t.string :middleinitial
      t.string :email
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.string :homephone
      t.string :workphone
      t.string :cellphone
      t.string :fax
      t.string :prefcontactmethod
      t.string :gender
      t.date :contactsince
      t.date :logininfosenton
      t.string :comments
      t.boolean :isprimary
      t.string  :photo_file_name
      t.string :photo_content_type
      t.integer  :photo_file_size
      t.datetime  :photo_updated_at

      t.timestamps
    end
	
    add_index :contacts, [:entity_id,:entity_type]
  end

  def self.down
    drop_table :contacts
  end
end
