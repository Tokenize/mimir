class Api::EventsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from User::NotAuthorized, with: :not_authorized

  skip_before_action :authenticate_user!

  before_action :load_user, only: :create
  before_action :load_device, only: :create

  def create
    event = @device.events.build(event_params)

    if event.save
      render json: event, status: :created
    else
      render json: { error: event.errors.full_messages }, status: :unprocessable_entity
    end
  end

  protected

  def load_user
    raise User::NotAuthorized if params[:auth_token].blank?

    @user = User.find_by!(auth_token: params[:auth_token])
  end

  def load_device
    @device = @user.devices.find_by!(uuid: params[:device])
  end

  def record_not_found
    render json: { error: 'Record not found' }, status: :not_found
  end

  def not_authorized
    render json: { error: 'Not authorized' }, status: :unauthorized
  end

  def event_params
    params.require(:event).permit(
      %w[command data description zone partition priority timestamp]
    )
  end
end
