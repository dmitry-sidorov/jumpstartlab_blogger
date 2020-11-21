class Article < ApplicationRecord
  has_many :comments
  has_many :taggings
  has_many :tags, through: :taggings

  def tag_list
    self.tags.collect do |tag|
      tag.name
    end.join(", ")
  end

  def tag_list=(tag_string)
    tag_names = tag_string.split(", ").map { |item| item.strip.downcase }.uniq
    self.tags = tag_names.map { |tag_name| Tag.find_or_create_by(name: tag_name) }
  end
end
