class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.integer :user_id
      t.string :title
      t.text :description
      t.string :status
      t.integer :total_comment
      t.datetime :last_commented

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
