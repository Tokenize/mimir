class User < ApplicationRecord
  class NotAuthorized < RuntimeError; end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :devices

  include UserAuthTokenGeneration

  validates :time_zone, inclusion: { in: ActiveSupport::TimeZone.us_zones.collect(&:name), allow_nil: true }

  after_create :regenerate_auth_token!
end
