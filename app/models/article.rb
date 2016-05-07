class Article < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :tags

  def words
    Word.where(name: content.split(" "))
  end
end
