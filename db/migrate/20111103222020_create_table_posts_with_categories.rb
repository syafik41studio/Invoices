class CreateTablePostsWithCategories < ActiveRecord::Migration
  def self.up
    create_table :posts_with_categories, :id => false do |t|
      t.integer :post_id
      t.integer :category_id
    end
  end

  def self.down
    drop_table :posts_with_categories
  end
end
