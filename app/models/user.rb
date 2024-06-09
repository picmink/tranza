class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_one_attached :profile_image
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  
 
  
  def get_profile_image(width, height)
      unless profile_image.attached?
          file_path = Rails.root.join('app/assets/images/no_image.jpg')
          profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      end 
     profile_image.variant(resize_to_limit: [width, height]).processed
  end
          
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "tag_id", "updated_at", "user_id"]
  end
  

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |guest|
      guest.passward = SecureRamdom.urlsafe_base64
      user.name = "ゲスト"
      user.is_deleted = false
    end
  end
  
  # def active_for_authentication?
  #   super && (is_deleted == false)
  # end
  
end