class PartySerializer < ActiveModel::Serializer
  attributes :id, :name
  has_one :user
 	has_many :requests
end
