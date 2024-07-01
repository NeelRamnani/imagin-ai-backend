class Image < ApplicationRecord
  belongs_to :user

  has_one_attached :image_file

  validates :image_file, presence: true
  validates :prompt, presence: true
  validates :user_id, presence: true
end
