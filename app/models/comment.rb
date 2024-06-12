class Comment < ApplicationRecord
  belongs_to :users
  belongs_to :posts

  validates :comment, presence: true
end
