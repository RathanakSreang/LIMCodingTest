class Page < ActiveRecord::Base
  has_many :page_contents, dependent: :destroy
  has_many :contents, through: :page_contents

  URL_FORMAT = /\A(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?\w/
  validates :url, presence: true
  validate :valid_url

  private

  def valid_url
    return if self.url.blank?

    self.url = "http://#{self.url}" unless self.url[/^https?/]

    unless self.url.match(URL_FORMAT)
      errors.add(:url, "#{self.url} is not an url")
    end
  end
end
