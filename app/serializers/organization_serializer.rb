class OrganizationSerializer
  include JSONAPI::Serializer

  attributes :id, :name, :logo_url

  attribute :albums do |organization, params|
    params && params[:admin] ? organization.albums : organization.albums.where(is_published: true)
  end

  attribute :users, serializer: UserSerializer, if: Proc.new{|record, params| params && params[:admin] == true}
  has_many :users, if: Proc.new{|record, params| params && params[:admin] == true}
  has_many :albums
end
