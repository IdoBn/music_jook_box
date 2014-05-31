class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :thumbnail

  def thumbnail
  	object.thumbnail
  end
end
