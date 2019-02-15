class Blog < ApplicationRecord
  belongs_to :user
  mount_uploader :blog_image, ImageUploader
  validates :title, presence: true
  validates :content, presence: true
  validates :address, presence: true
  geocoded_by :address
  after_validation :geocode
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user
end
