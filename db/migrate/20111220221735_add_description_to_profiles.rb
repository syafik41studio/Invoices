class AddDescriptionToProfiles < ActiveRecord::Migration
  def self.up
    add_column :profiles, :description, :string
  end

  def self.down
    remove_column :profiles, :description
  end
end
