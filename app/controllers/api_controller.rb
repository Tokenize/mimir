class ApiController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from User::NotAuthorized, with: :not_authorized

  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  protected

  def record_not_found
    render json: { error: 'Record not found' }, status: :not_found
  end

  def not_authorized
    render json: { error: 'Not authorized' }, status: :unauthorized
  end

  def load_user
    raise User::NotAuthorized if params[:auth_token].blank?

    @user = User.find_by!(auth_token: params[:auth_token])
  end

  def load_device
    @device = @user.devices.find_by!(uuid: params[:device])
  end
end
