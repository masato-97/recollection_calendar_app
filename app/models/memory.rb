class Memory < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 65_535 }
  validates :day, presence: true

  belongs_to :user
  has_one :post, dependent: :destroy

  has_one_attached :main_image
  has_one_attached :sub_image
end
