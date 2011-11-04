class CreatePostCategories < ActiveRecord::Migration
  def self.up
    create_table :post_categories do |t|
      t.string :name
      t.integer :parent_id
      t.integer :user_id
      t.timestamps
    end
    add_index :post_categories, :parent_id
    add_index :post_categories, :user_id
  end

  def self.down
    drop_table :post_categories
  end
end
