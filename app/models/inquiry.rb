class Inquiry < ApplicationRecord
  validates :email, presence: true
  validates :subject, presence: true
  validates :message, presence: true
end
