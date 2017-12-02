class AddAlbumIdToPics < ActiveRecord::Migration[5.1]
  def change
    add_column :pics, :album_id, :integer
  end
end
