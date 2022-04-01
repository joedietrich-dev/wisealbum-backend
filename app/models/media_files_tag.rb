class MediaFilesTag < ApplicationRecord
  belongs_to :media_file
  belongs_to :tag
end
