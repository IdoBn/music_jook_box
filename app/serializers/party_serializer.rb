class PartySerializer < ActiveModel::Serializer
  attributes :id, :name
 	has_many :requests
end
