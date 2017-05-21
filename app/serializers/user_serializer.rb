class UserSerializer < ActiveModel::Serializer
  attributes :id,
    :email,
    :role_list

  def role_list
    object.roles.map(&:name)
  end
end
