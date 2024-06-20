class Tag < ApplicationRecord
    has_many :post_tags, dependent: :destroy, foreign_key: 'tag_id'
    # タグは複数の投稿を持つ　それは、post_tagsを通じて参照できる
    has_many :posts, through: :post_tags
    
    def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "tag_name", "updated_at","image_attachment", "image_blob", "post_tags", "posts"]
    end
    def self.ransackable_associations(auth_object = nil)
    ["post_tags", "posts"]
    end
    
    validates :tag_name, uniqueness: true, presence: true
end
