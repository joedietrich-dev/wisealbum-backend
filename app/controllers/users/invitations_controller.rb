class Users::InvitationsController < Devise::InvitationsController
  respond_to :json
  before_action :configure_permitted_parameters

  def update
    super do |resource|
      if resource.errors.empty?
        render json: { 
          status: {message: "Invitation Accepted!", code: 200}, 
          data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
        }
      else
        render json: resource.errors, status: :unprocessable_entity
      end
    end
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:invite, keys: [:full_name, :organization_id, :role_id])
    end

  private

    def respond_with(resource, _opts = {})
    if resource.persisted?
      render json: {
        status: {code: 200, message: 'Signed up sucessfully'},
        data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
      }
    else
      render json: {
        status: {message: "User couldn't be created successfully. #{resource.errors.full_messages.to_sentence}"}
      }, status: :unprocessable_entity
    end
  end
end
