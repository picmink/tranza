class Favorite < ApplicationRecord
  belongs_to :post
  validates :post_id, uniqueness: { scope: :post_id }
end
