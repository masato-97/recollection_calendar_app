class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :memories, dependent: :destroy
  has_many :posts, dependent: :destroy

  has_one_attached :avatar

  def own?(object)
    id == object&.user_id
  end
end
