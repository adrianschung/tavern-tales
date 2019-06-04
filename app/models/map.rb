class Map < ApplicationRecord
  acts_as_taggable_on :tags
  belongs_to :user
  mount_uploader :picture, PictureUploader
end
