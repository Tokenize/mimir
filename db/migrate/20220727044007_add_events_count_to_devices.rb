class AddEventsCountToDevices < ActiveRecord::Migration[6.0]
  def change
    add_column :devices, :events_count, :integer, default: 0, null: false

    Device.all.each do |device|
      Device.reset_counters(device.id, :events)
    end
  end
end
