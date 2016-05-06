class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :name
      t.string :translation
      t.boolean :known
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
