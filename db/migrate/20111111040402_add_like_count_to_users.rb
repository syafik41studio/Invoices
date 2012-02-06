class AddLikeCountToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :like_count, :integer
  end

  def self.down
    remove_column :users, :like_count
  end
end
