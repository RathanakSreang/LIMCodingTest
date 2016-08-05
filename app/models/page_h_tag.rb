class PageHTag < PageTag
  belongs_to :h_tag, foreign_key: 'tag_id'
end
