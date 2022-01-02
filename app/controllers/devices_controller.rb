class DevicesController < ApplicationController
  before_action :load_device, only: %i(edit update destroy)
  before_action :set_sidebar_entry, only: %i[new edit]

  def index
    @devices = current_user.devices.order(updated_at: :desc, last_seen_at: :desc)
  end

  def new
    @device = current_user.devices.build
  end

  def create
    @device = current_user.devices.build(device_params.merge(uuid: SecureRandom.uuid))

    if @device.save
      redirect_to devices_path, notice: "Device has been successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @device.update(device_params)
      redirect_to devices_path, notice: "Device #{@device.name} has been successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @device.destroy

    redirect_to devices_path, notice: "Device #{@device.name} has been successfully deleted."
  end

  protected

  def device_params
    params.require(:device).permit(:name)
  end

  def load_device
    @device = current_user.devices.find(params[:id])
  end

  def set_sidebar_entry
    @sidebar_entry = 'Devices'
  end
end
