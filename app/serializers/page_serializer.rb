class PageSerializer < ActiveModel::Serializer
  attributes :id, :url
  has_many :a_tags
  has_many :h_tags
end
