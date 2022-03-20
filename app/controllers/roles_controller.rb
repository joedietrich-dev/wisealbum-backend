class RolesController < ApplicationController
  before_action :authenticate_user!

  # GET /roles
  def index
    if current_user.super_admin?
      @roles = Role.all
    else
      @roles = Role.where("name != 'System Administrator'")
    end 
    render json: @roles
  end
end
