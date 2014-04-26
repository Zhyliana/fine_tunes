class RemoveTrackValidationFromAlbum < ActiveRecord::Migration
  def change
    remove_column :albums, :track_id
    add_column :albums, :track_id, :integer
    
  end
end
