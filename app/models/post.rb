class Post < ApplicationRecord
    has_one_attached :image
    belongs_to :user
    has_many :post_tags, dependent: :destroy
    has_many :tags, through: :post_tags
    has_many :favorites, dependent: :destroy
    has_many :comments, dependent: :destroy
    
    def get_image(width, height)
        image.variant(resize_to_limit: [width, height]).processed
    end 
    
    def favorited_by?(user)
        favorites.exists?(user_id: user.id)
    end
    
    def comment_count
        comments.count
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
    
    def save_tags(tags) #
        tags.each do |new_tags|
            self.tags.find_or_create_by(tag_name: new_tags)
        end 
    end 
    
    def update_tags(latest_tags)#タグ付けの更新用メソッド
        if self.tags.empty?
            latest_tags.each do |latest_tag|
                self.tags.find_or_create_by(tag_name: latest_tag)
            end
        elsif latest_tags.empty?
            self.tagas.each do |tag|
                self.tags.delete(tag)
            end
        else
            current_tags = self.tags.pluck(:tag_name)
            old_tags = current_tags - latest_tags
            new_tags = latest_tags - current_tags
            
            old_tags.each do |old_tag|
                tag = self.tags.find_by(tag_name: old_tag)
                self.tags.delete(tag) if tag.present?
            end 
            
            new_tags.each do |new_tag|
                self.tags.find_or_create_by(tag_name: new_tag)
            end 
        end 
    end
    
    validates :stone_name, presence: true
    validates :caption, presence: true
    validates :image, presence: true
end
