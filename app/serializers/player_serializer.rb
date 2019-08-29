class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :second_name, :last_name, :nick_name,
              :id_number, :dob, :phone_number
  
  has_many :commentaries
  has_many :fixture_squad
end
