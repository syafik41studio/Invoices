class AddTotalLikeToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :total_like, :integer, :default => 0
  end

  def self.down
    remove_column :posts, :total_like
  end
end
