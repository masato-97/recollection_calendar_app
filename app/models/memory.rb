class Memory < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 65_535 }

  belongs_to :user
  has_one :post, dependent: :destroy

  mount_uploader :main_image, MainImageUploader
  mount_uploader :sub_image, SubImageUploader
end
