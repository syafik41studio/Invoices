class ChangeColumnPhotoUpdatedAtToDatetimeInContacts < ActiveRecord::Migration
  def self.up
    change_column :contacts, :photo_updated_at, :datetime
  end

  def self.down
    change_column :contacts, :photo_updated_at, :date
  end
end
