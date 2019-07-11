class Device < ApplicationRecord
  belongs_to :user
  has_many :events

  validates :name, :user_id, presence: true
  validates :uuid, presence: true, uniqueness: true
end
