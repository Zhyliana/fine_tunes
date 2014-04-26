class Note < ActiveRecord::Base
  validates(
    :user_id,
    :track_id,
    :body,
    presence: true
    )
  
  
  belongs_to(
    :track,
    class_name: "Track",
    foreign_key: :track_id,
    primary_key: :id
    )
    
  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :track_id,
    primary_key: :id
    )
end
