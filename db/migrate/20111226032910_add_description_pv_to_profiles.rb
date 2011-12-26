class AddDescriptionPvToProfiles < ActiveRecord::Migration
  def self.up
    add_column :profiles, :description_pv, :boolean, :default => false
  end

  def self.down
    remove_column :profiles, :description_pv
  end
end
