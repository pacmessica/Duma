class CreateArticlesTagsJoinTable < ActiveRecord::Migration
  def self.up
    create_table :articles_tags, :id => false do |t|
      t.integer :article_id
      t.integer :tag_id
    end
    add_index :articles_tags, [:article_id, :tag_id]
  end
end
