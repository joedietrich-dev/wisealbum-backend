class OrganizationsController < ApplicationController
  before_action :set_organization, only: %i[ show update destroy ]
  before_action :authenticate_user!, only: %i[ create update destroy]

  # GET /organizations
  def index
    @organizations = Organization.all

    render json: @organizations
  end

  # GET /organizations/1
  def show
    render json: @organization
  end

  # POST /organizations
  def create
    # Superadmin -> create organization, not added to it
    # Not Superadmin, no org_id -> create org, added to it
    # Not Superadmin, org_id -> fail
    if (!current_user.super_admin? and current_user.organization_id) or !(current_user.super_admin? or current_user.org_owner?)
      render json: {errors: "You cannot create an organization"}, status: :forbidden
      return
    end 

    @organization = Organization.new(organization_params)
    @organization.users << current_user unless current_user.super_admin?
    if @organization.save
      render json: @organization, status: :created, location: @organization
    else
      render json: @organization.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /organizations/1
  def update
    if @organization.update(organization_params)
      render json: @organization
    else
      render json: @organization.errors, status: :unprocessable_entity
    end
  end

  # DELETE /organizations/1
  def destroy
    @organization.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def organization_params
      params.require(:organization).permit(:name, :url_path, :logo_url, :is_blocked)
    end
end
