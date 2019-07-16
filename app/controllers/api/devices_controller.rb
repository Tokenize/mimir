class Api::DevicesController < ApiController
  before_action :load_user, only: :update
  before_action :load_device, only: :update

  def update
    if @device.update(last_seen_at: Time.current)
      render json: @device, status: :accepted
    else
      render json: { error: @device.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
