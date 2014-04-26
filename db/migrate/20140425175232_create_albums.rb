class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :name, null: false, unique: true
      t.string :year
      t.integer :band_id, null: false
      t.integer :track_id, null: false

      t.timestamps
    end
    
    add_index :albums, :band_id
    add_index :albums, :track_id
  end
end
