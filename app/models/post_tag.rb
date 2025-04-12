class PostTag < ApplicationRecord
  has_many :middle_post_tags, dependent: :destroy
  has_many :posts, through: :middle_post_tags

  validates :name, presence: true
end
