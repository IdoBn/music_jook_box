class PartySerializer < ActiveModel::Serializer
  attributes :id, :name, :latitude, :longitude
  has_one :user
 	has_many :requests
end
