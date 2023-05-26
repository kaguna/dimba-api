class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :second_name, :last_name, :nick_name,
             :id_number, :dob, :phone_number, :full_name

  belongs_to :team, serializer: TeamSerializer

  def full_name
    "#{object.first_name} #{object.second_name} #{object.last_name}".titleize
  end
end
