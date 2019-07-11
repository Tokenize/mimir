class EventsController < ApplicationController
  before_action :load_device, only: :index

  def index
    @events = @device.events
  end

  protected

  def load_device
    @device = current_user.devices.find(params[:device_id])
  end
end
