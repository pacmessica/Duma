class AddArticleIdToTags < ActiveRecord::Migration
  def change
    add_column :tags, :article_id, :integer
    add_foreign_key(:tags, :articles)
  end
end
