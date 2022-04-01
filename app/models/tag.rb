class Tag < ApplicationRecord
  has_many :media_files, through: :media_files_tags
end
