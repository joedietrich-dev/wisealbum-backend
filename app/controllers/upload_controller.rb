class UploadController < ApplicationController
  before_action :authenticate_user!

  def create    
    if current_user.super_admin? or current_user.org_owner? or current_user.contributor?
      response = { signedUrl: get_presigned_url(upload_params) }
      render json: response
    else
      render json: {errors: "You cannot upload"}, status: :forbidden
    end
  end

  private
    def upload_params
      params.require(:upload).permit(:filename)
    end

    def get_presigned_url(upload_params)
      object_key = upload_params[:filename]
      bucket = Aws::S3::Bucket.new ENV['S3_BUCKET']
      url = bucket.object(object_key).presigned_url(:put)
      # presigned_post = bucket.object(object_key)
      puts "Created presigned URL: #{url}."
      URI(url)
    rescue Aws::Errors::ServiceError => e
      puts "Couldn't create presigned URL for #{bucket.name}:#{object_key}. Here's why: #{e.message}"
    end
end
