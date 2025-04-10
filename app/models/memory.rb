class Memory < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 65_535 }
  validates :day, presence: true

  belongs_to :user
  has_one :post, dependent: :destroy

  has_one_attached :main_image
  has_one_attached :sub_image

  scope :memories_this_month, -> (user_id, start_date) {
    where(user_id: user_id, day: start_date.beginning_of_month..start_date.end_of_month)
  }
  scope :memories_last_month, -> (user_id, start_date) {
    last_month_start = start_date.last_month.beginning_of_month
    last_month_end = start_date.last_month.end_of_month
    where(user_id: user_id, day: last_month_start..last_month_end)
  }
  scope :memories_2month_ago, -> (user_id, start_date) {
    two_month_ago = start_date.last_month.last_month
    last_month_start = two_month_ago.beginning_of_month
    last_month_end = two_month_ago.end_of_month
    where(user_id: user_id, day: last_month_start..last_month_end)
  }
  scope :memories_3month_ago, -> (user_id, start_date) {
    three_month_ago = start_date.last_month.last_month.last_month
    last_month_start = three_month_ago.beginning_of_month
    last_month_end = three_month_ago.end_of_month
    where(user_id: user_id, day: last_month_start..last_month_end)
  }
  scope :memories_4month_ago, -> (user_id, start_date) {
    four_month_ago = start_date.last_month.last_month.last_month.last_month
    last_month_start = four_month_ago.beginning_of_month
    last_month_end = four_month_ago.end_of_month
    where(user_id: user_id, day: last_month_start..last_month_end)
  }
  scope :memories_5month_ago, -> (user_id, start_date) {
    five_month_ago = start_date.last_month.last_month.last_month.last_month.last_month
    last_month_start = five_month_ago.beginning_of_month
    last_month_end = five_month_ago.end_of_month
    where(user_id: user_id, day: last_month_start..last_month_end)
  }
  scope :memories_6month_ago, -> (user_id, start_date) {
    six_month_ago = start_date.last_month.last_month.last_month.last_month.last_month.last_month
    last_month_start = six_month_ago.beginning_of_month
    last_month_end = six_month_ago.end_of_month
    where(user_id: user_id, day: last_month_start..last_month_end)
  }
end
