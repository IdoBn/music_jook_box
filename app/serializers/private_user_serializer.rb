class PrivateUserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :thumbnail, :parties

  def thumbnail
  	object.thumbnail
  end

  def parties
  	object.parties
  end
end
