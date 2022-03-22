class OrganizationSerializer
  include JSONAPI::Serializer
  attributes :id, :name
end
