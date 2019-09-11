class UserSerializer < ActiveModel::Serializer
  attributes :id, :username

  has_many :center_referee, class_name: "Fixture", foreign_key: "center_referee_id"
  has_many :right_side_referee, class_name: "Fixture", foreign_key: "right_side_referee_id"
  has_many :left_side_referee, class_name: "Fixture", foreign_key: "left_side_referee_id"
end
