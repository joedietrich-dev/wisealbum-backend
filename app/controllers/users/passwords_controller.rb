# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  respond_to :json
  include RackSessionFixController

  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  def create
    puts "hi"
    @user = User.find_by(email: params[:email])
    if @user.present?
      @user.send_reset_password_instructions
      render json: {
        status: {code: 200, message: 'Reset instructions sent sucessfully'}
      }
    else
      render :text => "no such email"
    end
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  def update
    @user = User.reset_password_by_token(password: params[:password], password_confirmation: params[:password_confirmation], reset_password_token: params[:reset_password_token])

    if @user.errors.empty?
      render json: {
        status: {code: 200, message: 'Password reset sucessfully'}
      }
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
