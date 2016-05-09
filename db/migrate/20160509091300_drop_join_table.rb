class DropJoinTable < ActiveRecord::Migration
  def change
    drop_join_table :articles, :tags
  end
end
