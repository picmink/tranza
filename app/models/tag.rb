class Tag < ApplicationRecord
    has_many :user
    has_many :post
    belongs_to :user
    belongs_to :post
end
