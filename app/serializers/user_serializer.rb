class UserSerializer
  include JSONAPI::Serializer
  set_id :organization_id
  set_id :role_id
  attributes :id, :email, :full_name, :created_at, :organization_id, :role_id
  belongs_to :organization
  belongs_to :role
end
