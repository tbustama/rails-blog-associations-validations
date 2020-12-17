class Post < ApplicationRecord
  belongs_to :user
  has_many :post_tags
  has_many :tags, through: :post_tags
  validates :name, presence: true
  validates :content, presence: true

  def tag_ids=(tags)
    tags.each do |tag|
      new_tag = Tag.find_or_create_by(id: tag)
      post_tag = PostTag.create(post_id: self.id, tag_id: new_tag.id)
      self.tags << new_tag
    end
  end
end
