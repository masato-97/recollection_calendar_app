class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 65_535 }

  belongs_to :user
  belongs_to :memory

  has_many :middle_post_tags, dependent: :destroy
  has_many :post_tags, through: :middle_post_tags
  has_many :favorites, dependent: :destroy

  def save_with_post_tags(tag_names:)
    ActiveRecord::Base.transaction do
      self.post_tags = tag_names.map { |name| PostTag.find_or_initialize_by(name: name.strip) }
      save!
    end
    true
  rescue StandardError
    false
  end

  def tag_names
    # NOTE: pluckだと新規作成失敗時に値が残らない(返り値がnilになる)
    post_tags.map(&:name).join(",")
  end
end
