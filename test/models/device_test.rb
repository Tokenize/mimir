require 'test_helper'

class DeviceTest < ActiveSupport::TestCase
  test "requires user" do
    device = Device.new

    assert_not device.valid?
    assert_not device.errors[:user_id].blank?
  end

  test "requires name" do
    device = Device.new

    assert_not device.valid?
    assert_not device.errors[:name].blank?
  end

  test "requires uuid" do
    device = Device.new

    assert_not device.valid?
    assert_not device.errors[:uuid].blank?
  end

  test "enforces uniqueness on uuid" do
    device = Device.new(uuid: devices(:one).uuid)

    assert_not device.valid?
    assert_match /has already been taken/, device.errors[:uuid].join('.')
  end
end
