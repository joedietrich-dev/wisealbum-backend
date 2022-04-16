class OrganizationSerializer
  include JSONAPI::Serializer

  attributes :id, :name, :albums, :logo_url
  attribute :users, serializer: UserSerializer
  has_many :users
  has_many :albums
end
