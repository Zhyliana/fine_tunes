# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  year       :string(255)
#  band_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#  audio      :string(255)
#

class Album < ActiveRecord::Base
  belongs_to(
    :band,
    class_name: "Band",
    foreign_key: :band_id,
    primary_key: :id
    )
    
  has_many(
    :tracks,
    class_name: "Track",
    foreign_key: :album_id,
    primary_key: :id,
    dependent: :destroy
    )
    
  validates(
    :name,
    :band_id,
    :audio,
    presence: true
    )
  
  validates(
    :name,
    uniqueness: true
    )
    
  validates(
    :audio,
    inclusion:  %w(STUDIO LIVE)
    )
    
end
