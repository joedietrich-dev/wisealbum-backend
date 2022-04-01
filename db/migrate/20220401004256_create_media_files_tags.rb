class CreateMediaFilesTags < ActiveRecord::Migration[7.0]
  def change
    create_table :media_files_tags do |t|
      t.belongs_to :media_file, null: false, foreign_key: true
      t.belongs_to :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
