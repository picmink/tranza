class PostTag < ApplicationRecord
  belongs_to :post
  belongs_to :tag
  validates :post_id, presence: true
  validates :tag_id, presence: true

  def save
    post = Post.create(stone_name: stone_name, caption: caption, user_id: user_id, image: image)
    tag = Tag.where(tag_name: tag_name).first_or_initialize
    tag.save
    
    PostTags.create(post_id: post.id, tag_id: tag.id)
  end 
  
  def update
    @post = Post.where(id: post_id)
    post = @post.update(stone_name: stone_name, caption: caption, user_id: user_id, image: image)
    tag = Tag.where(tag_name: tag_name).first_or_initialize
    tag.save
    
    map = PostTags.where(post_id: post_id)
    map.update(post_id: post_id, tag_id: tag_id)
  end 
  
end
