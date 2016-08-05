class Tag < ActiveRecord::Base
  validates :content, presence: true
end
