class CreatePatients < ActiveRecord::Migration
  def self.up
    create_table :patients do |t|
      t.integer :user_id
      t.string :name
      t.float :age
      t.text :description
      t.string :visit
      t.string :primary_contact
      t.string :relation
      t.string :email
      t.string :phone_number
      t.string :city
      t.string :state

      t.timestamps
    end
  end

  def self.down
    drop_table :patients
  end
end
