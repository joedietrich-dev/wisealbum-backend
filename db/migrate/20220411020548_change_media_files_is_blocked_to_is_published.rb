class ChangeMediaFilesIsBlockedToIsPublished < ActiveRecord::Migration[7.0]
  def change
    rename_column :media_files, :is_hidden, :is_published
    change_column_default :media_files, :is_published, false
    change_column_default :media_files, :is_blocked, false
  end
end
