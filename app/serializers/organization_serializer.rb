class OrganizationSerializer
  include JSONAPI::Serializer

  attributes :id, :name, :albums
  attribute :users, serializer: UserSerializer
  has_many :users
  has_many :albums
end
