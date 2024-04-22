class Post < ApplicationRecord
    has_one_attached :image
    belongs_to :user
    
    def get_image(width, height)
        image
    end 
end
