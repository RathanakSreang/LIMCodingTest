class PageATag < PageTag
  belongs_to :a_tag, foreign_key: 'tag_id'
end
