class CreateAlbums < ActiveRecord::Migration[7.0]
  def change
    create_table :albums do |t|
      t.string :name
      t.string :description
      t.string :url_path
      t.string :cover_image_path
      t.boolean :is_published
      t.boolean :is_blocked
      t.belongs_to :organization, null: false, foreign_key: true

      t.timestamps
    end
  end
end
