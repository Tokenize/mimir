class EventsController < ApplicationController
  include Pagy::Backend

  before_action :load_device, only: :index

  def index
    @sidebar_entry = 'Devices'
    @pagy, @events = pagy(@device.events.order(timestamp: :desc))
  end

  protected

  def load_device
    @device = current_user.devices.find(params[:device_id])
  end
end
