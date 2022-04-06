class UploadController < ApplicationController
  def create
    response = { upload_url: get_presigned_url(upload_params) }
    render json: response
  end

  private
    def upload_params
      params.require(:upload).permit(:filename)
    end

    def get_presigned_url(upload_params)
      object_key = upload_params[:filename]
      bucket = Aws::S3::Bucket.new ENV['S3_BUCKET']
      url = bucket.object(object_key).presigned_url(:put)
      puts "Created presigned URL: #{url}."
      URI(url)
    rescue Aws::Errors::ServiceError => e
      puts "Couldn't create presigned URL for #{bucket.name}:#{object_key}. Here's why: #{e.message}"
    end
end
