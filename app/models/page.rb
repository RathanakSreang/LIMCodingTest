class Page < ActiveRecord::Base
  has_many :page_a_tags, dependent: :destroy
  has_many :a_tags, through: :page_a_tags
  has_many :page_h_tags, dependent: :destroy
  has_many :h_tags, through: :page_h_tags

  URL_FORMAT = /\A(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?\w/
  validates :url, presence: true
  validate :valid_url

  def fetch_contents
    page = Nokogiri::HTML(RestClient.get(self.url))
    page.css('h1', 'h2', 'h3').each do |h_tag|
      next if h_tag.blank? || h_tag.content.blank?
      self.h_tags << HTag.find_or_create_by!(content: h_tag.content)
    end
    page.css('a').each do |link|
      next if link.blank? || link['href'].blank?
      self.a_tags << ATag.find_or_create_by!(content: link['href'])
    end
  end

  private

  def valid_url
    return if self.url.blank?

    self.url = "http://#{self.url}" unless self.url[/^https?/]

    unless self.url.match(URL_FORMAT)
      errors.add(:url, "#{self.url} is not an url")
    end
  end
end
