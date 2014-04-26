class AddaudioTypetoAlbum < ActiveRecord::Migration
  def change
    add_column :albums, :audio, :string
    add_column :tracks, :featured, :string, default: "REGULAR"
    add_column :tracks, :lyrics, :text
  end
end
