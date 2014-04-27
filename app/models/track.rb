# == Schema Information
#
# Table name: tracks
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  album_id   :integer          not null
#  created_at :datetime
#  updated_at :datetime
#  featured   :string(255)      default("REGULAR")
#  lyrics     :text
#

class Track < ActiveRecord::Base
  belongs_to(
    :album,
    class_name: "Album",
    foreign_key: :album_id,
    primary_key: :id
    )
    
  has_one(
    :band,
    class_name: "Band",
    through: :album,
    source: :band
    )
    
  has_many(
    :notes,
    class_name: "Note",
    foreign_key: :track_id,
    primary_key: :id
    )
    
  validates(
    :name,
    :album_id, 
    presence: true
    )
    
  validates(
    :name,
    uniqueness: true
    )
  
  validates(
    :featured,
    inclusion:  %w(REGULAR BONUS)
    )
  def lyric_lines
    lyrics.chomp.split("\r").map { |line| "#{line}" }
  end
end
