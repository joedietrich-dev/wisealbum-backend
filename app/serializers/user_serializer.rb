class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :full_name, :created_at
end
