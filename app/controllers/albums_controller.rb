class AlbumsController < ApplicationController
  before_action :set_album, only: %i[ show update destroy ]
  before_action :authenticate_user!, only: %i[ create update destroy]
  before_action :set_organization

  # GET /organizations/:org_id/albums
  def index
    @albums = Album.where(organization: @organization)

    render json: @albums
  end

  # GET /organizations/:org_id/albums/1
  def show
    render json: @album
  end

  # POST /organizations/:org_id/albums
  def create
    if user_can_create?
      @album = Album.new(album_params)
      @album.organization = @organization

      if @album.save
        render json: @album, status: :created
      else
        render json: @album.errors, status: :unprocessable_entity
      end
    else
      render json: {errors: "You cannot create an album"}, status: :forbidden
    end
  end

  # PATCH/PUT /organizations/:org_id/albums/1
  def update
    if user_can_contribute?
      if @album.update(album_params)
        render json: @album
      else
        render json: @album.errors, status: :unprocessable_entity
      end
    else
      render json: {errors: "You cannot update an album"}, status: :forbidden
    end
  end

  # DELETE /organizations/:org_id/albums/1
  def destroy
    if user_can_contribute?
      @album.destroy
    else
      render json: {errors: "You cannot update an album"}, status: :forbidden
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.find(params[:id])
    end

    def set_organization
      @organization = Organization.find(params[:organization_id])
    end

    def user_can_contribute?
      @album = @album || Album.find(params[:id])
      return false unless current_user
      current_user.super_admin? or ((current_user.org_owner? or current_user.contributor?) and current_user.organization_id == @album.organization_id)
    end

    def user_can_create?
      return false unless current_user
      current_user.super_admin? or ((current_user.org_owner? or current_user.contributor?) and current_user.organization_id == @organization.id)
    end

    # Only allow a list of trusted parameters through.
    def album_params
      params.require(:album).permit(:name, :description, :url_path, :cover_image_path, :is_published, :is_blocked, :organization_id)
    end
end
