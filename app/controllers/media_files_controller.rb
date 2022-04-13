class MediaFilesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  before_action :authenticate_user!, only: %i[]
  before_action :set_media_file, only: %i[ show update destroy ]
  before_action :set_album, only: %i[ index create ]

  # GET /media_files?album_id=<album_id>
  def index
    if user_can_contribute?
      @media_files = MediaFile.where(album_id: @album.id).order(:order)
    elsif @album.is_published and !@album.is_blocked
      @media_files = MediaFile.where(album_id: @album.id).where(is_blocked: false).where(is_published: true).order(:order)
    else
      @media_files = []
    end
    render json: @media_files
  end

  # GET /media_files/1
  def show
    render json: @media_file
  end

  # POST /media_files
  def create    
    if user_can_contribute?
      @media_file = MediaFile.new(media_file_params)
      if @media_file.save
        render json: @media_file, status: :created, location: @media_file
      else
        render json: @media_file.errors, status: :unprocessable_entity
      end
    else
      render json: {errors: "You cannot upload"}, status: :forbidden
    end
  end

  # PATCH/PUT /media_files/1
  def update
    if user_can_contribute?
      if @media_file.update(media_file_params)
        render json: @media_file
      else
        render json: @media_file.errors, status: :unprocessable_entity
      end
    else
      render json: {errors: "You cannot edit"}, status: :forbidden
    end
  end

  # DELETE /media_files/1
  def destroy
    if user_can_contribute?
      @media_file.destroy
      # TODO Delete media file using s3
    else
      render json: {errors: "You cannot edit"}, status: :forbidden
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_media_file
      @media_file = MediaFile.find(params[:id])
    end

    def set_album 
      @album = Album.find(params[:album_id])
    end

    # Only allow a list of trusted parameters through.
    def media_file_params
      params.require(:media_file).permit(:file_type, :url, :description, :order, :is_blocked, :is_published, :album_id)
    end

    def user_can_contribute?
      @album = @album || Album.find(@media_file.album_id)
      return false unless current_user
      current_user.super_admin? or ((current_user.org_owner? or current_user.contributor?) and current_user.organization_id == @album.organization_id)
    end

    def render_not_found_response
      render json: { error: "Could not find record" }, status: :not_found
    end
end
