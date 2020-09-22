class Blog < ApplicationRecord
  validates :content, presence: true
  validates :image, presence: true
  mount_uploader :image, ImageUploader
  belongs_to :user
  has_many :favorites, dependent: :destroy
end
