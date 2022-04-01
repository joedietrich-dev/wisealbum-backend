class MediaFilesController < ApplicationController
  before_action :set_media_file, only: %i[ show update destroy ]

  # GET /media_files
  def index
    @media_files = MediaFile.all

    render json: @media_files
  end

  # GET /media_files/1
  def show
    render json: @media_file
  end

  # POST /media_files
  def create
    @media_file = MediaFile.new(media_file_params)

    if @media_file.save
      render json: @media_file, status: :created, location: @media_file
    else
      render json: @media_file.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /media_files/1
  def update
    if @media_file.update(media_file_params)
      render json: @media_file
    else
      render json: @media_file.errors, status: :unprocessable_entity
    end
  end

  # DELETE /media_files/1
  def destroy
    @media_file.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_media_file
      @media_file = MediaFile.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def media_file_params
      params.require(:media_file).permit(:type, :url, :description, :order, :is_blocked, :is_hidden, :album_id)
    end
end
