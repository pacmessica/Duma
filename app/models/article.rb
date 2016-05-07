class Article < ActiveRecord::Base
  belongs_to :user
  has_many :tags

  def words
    Word.where(name: content.split(" "))
  end
end
