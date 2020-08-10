class Event < ApplicationRecord
  belongs_to :device
  has_one :user, through: :device

  validates :command, :description, :device_id, :timestamp, presence: true

  after_create :update_device_last_seen_at

  private

  def update_device_last_seen_at
    device.update!(last_seen_at: Time.current)
  end
end
