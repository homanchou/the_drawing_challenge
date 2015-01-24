class Page < ActiveRecord::Base

  validates_presence_of :slug
  validates_presence_of :title
  validates_presence_of :body

  validates_uniqueness_of :slug

  before_save :sanitize_slug

  def sanitize_slug
    self.slug = self.slug.to_s.strip.downcase.gsub(/[^a-z0-9]/,'-')
  end

  def to_param
    slug
  end

end
