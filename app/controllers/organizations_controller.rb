class OrganizationsController < ApplicationController
  before_action :authenticate_user!, only: %i[ index create update destroy]
  before_action :set_organization, only: %i[ show update destroy ]

  # GET /organizations
  def index
    @organizations = Organization.all

    render json: @organizations
  end

  # GET /organizations/1
  def show
    render json: OrganizationSerializer.new(@organization).serializable_hash[:data][:attributes]
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
    # if the current user is not (an admin or (an owner of the specific org)
    if !(current_user.super_admin? || (current_user.org_owner? && current_user.organization_id == @organization.id))
      render json: {errors: "You cannot edit this organization"}, status: :forbidden
      return
    end

    if @organization.update(organization_params)
      render json: OrganizationSerializer.new(@organization).serializable_hash[:data][:attributes]
    else
      render json: @organization.errors, status: :unprocessable_entity
    end
  end

  # DELETE /organizations/1
  def destroy
    if !(current_user.super_admin? || (current_user.org_owner? && current_user.organization_id == @organization.id))
      @organization.destroy 
    else
      render json: {errors: "You cannot edit this organization"}, status: :forbidden
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def organization_params
      params.require(:organization).permit(:id, :name, :url_path, :logo_url, :is_blocked)
    end
end