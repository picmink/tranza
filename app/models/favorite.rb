class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :user_id, uniquenes: { scope: :post_id }
end
