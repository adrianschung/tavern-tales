class Photo < ApplicationRecord
  belongs_to :map
  mount_uploader :picture, PictureUploader
end
