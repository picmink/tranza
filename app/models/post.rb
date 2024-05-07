class Post < ApplicationRecord
    has_one_attached :image
    belongs_to :user
    has_many :post_tags, dependent: :destroy
    has_many :tags, through: :post_tags
    
    def get_image(width, height)
        image.variant(resize_to_limit: [width, height]).processed
    end 
    
    def self.ransackable_attributes(auth_object = nil)
    ["caption", "created_at", "id", "stone_name", "tag_id", "updated_at", "user_id"]
    end
    
    def save_tag(sent_tags)
        current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
        old_tags = current_tags - sent_tags
        new_tags = sent_tags - current_tags
        
        old_tags.each do |old|
            self.tag.delete Tag.find_by(tag_name: old)
        end 
        
        new_tags.each do |new|
            new_post_tag = Tag.find_or_create_by(tag_name: new)
            self.tags << new_post_tag
        end 
    end 
end
