class CreateMediaFiles < ActiveRecord::Migration[7.0]
  def change
    create_table :media_files do |t|
      t.string :type
      t.string :url
      t.string :description
      t.integer :order
      t.boolean :is_blocked
      t.boolean :is_hidden
      t.belongs_to :album, null: false, foreign_key: true

      t.timestamps
    end
  end
end
