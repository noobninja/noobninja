ActsAsTaggableOn::Tag.class_eval do
  before_validation :set_name_and_slug

  def set_name_and_slug
    slugged_name = name.downcase.gsub(" ", "-")
    self.name = slugged_name
    self.slug = ERB::Util.url_encode(slugged_name)
  end
end