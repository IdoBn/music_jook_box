class RequestSerializer < ActiveModel::Serializer
  attributes :id, :author, :party_id, :thumbnail,
  					 :url, :created_at, :title, :position

  has_one :user
  has_many :likes
end
