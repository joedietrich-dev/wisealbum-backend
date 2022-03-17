class CreateOrganizations < ActiveRecord::Migration[7.0]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :url_path
      t.string :logo_url
      t.boolean :is_blocked

      t.timestamps
    end
  end
end
