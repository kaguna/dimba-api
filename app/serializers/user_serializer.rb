class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :email_confirmed

end
