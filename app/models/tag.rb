class Tag < ActiveRecord::Base
  has_many :texts
  belong_to :user
end
