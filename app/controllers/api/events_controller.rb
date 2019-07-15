class Api::EventsController < ApiController
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

  def event_params
    params.require(:event).permit(
      %w[command data description zone partition priority timestamp]
    )
  end
end
