class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 65_535 }
  validates :title, presence: true
  validates :body, presence: true

  belongs_to :user
  belongs_to :memory
end
