class OrganizationSerializer
  include JSONAPI::Serializer

  attributes :id, :name
  attribute :users, serializer: UserSerializer
  has_many :users
end
