# app/models/image.rb
class Image < ApplicationRecord
    validates :url, presence: true
  end