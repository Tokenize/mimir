class Event < ApplicationRecord
  belongs_to :device
  has_one :user, through: :device

  validates :command, :description, :device_id, :timestamp, presence: true
end
