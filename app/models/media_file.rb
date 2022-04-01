class MediaFile < ApplicationRecord
  belongs_to :album
  has_many :tags, through: :media_files_tags
end
