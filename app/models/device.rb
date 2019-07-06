class Device < ApplicationRecord
  belongs_to :user

  validates :name, :user_id, presence: true
  validates :uuid, presence: true, uniqueness: true
end
