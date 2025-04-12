class Tag < ApplicationRecord
  has_many :middle_tags, dependent: :destroy
  has_many :memories, through: :middle_tags

  validates :name, presence: true
end
