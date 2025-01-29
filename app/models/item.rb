class Item < ApplicationRecord
  validates :image, presence: true

  has_attached_file :image, validate_media_type: false
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  validates :category, presence: true
  validates :name, presence: true
  validates :price, presence: true
end
