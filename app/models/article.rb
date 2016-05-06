class Article < ActiveRecord::Base
  belongs_to :user

  def words
    Word.where(name: content.split(" "))
  end
end
