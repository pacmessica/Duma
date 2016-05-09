class Word < ActiveRecord::Base
  belongs_to :user

  validates_format_of :name, :with => /\A[A-Za-z]+\z/

  def self.study_words
    where(known: false)
  end

  def self.known_words
    where(known: true)
  end

end
