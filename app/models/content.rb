class Content < ActiveRecord::Base
  validates :sentence, presence: true
end
