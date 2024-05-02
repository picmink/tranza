class Post < ApplicationRecord
    has_one_attached :image
    belongs_to :user
    
    def get_image(width, height)
        image.variant(resize_to_limit: [width, height]).processed
    end 
    
    def self.ransackable_attributes(auth_object = nil)
    ["caption", "created_at", "id", "stone_name", "tag_id", "updated_at", "user_id"]
    end
end
