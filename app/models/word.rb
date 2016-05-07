class Word < ActiveRecord::Base
  belongs_to :user

  def self.study_words
    where(known: false)
  end

  def self.known_words
    where(known: true)
  end

end
