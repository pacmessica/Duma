class Tag < ActiveRecord::Base
  has_many :texts
  belongs_to :articles
end
