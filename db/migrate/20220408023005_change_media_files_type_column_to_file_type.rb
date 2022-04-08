class ChangeMediaFilesTypeColumnToFileType < ActiveRecord::Migration[7.0]
  def change
    rename_column :media_files, :type, :file_type
  end
end
