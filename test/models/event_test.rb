require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test "requires device" do
    event = Event.new

    assert_not event.valid?
    assert event.errors[:device_id].present?
  end

  test "requires command" do
    event = Event.new

    assert_not event.valid?
    assert event.errors[:command].present?
  end

  test "requires description" do
    event = Event.new

    assert_not event.valid?
    assert event.errors[:description].present?
  end

  test "requires timestamp" do
    event = Event.new

    assert_not event.valid?
    assert event.errors[:timestamp].present?
  end

  test "after_create callback updates device's last_seen_at" do
    device = devices(:one)
    original_last_seen_at = device.last_seen_at

    travel_to(5.minutes.from_now) do
      event = device.events.create!(events(:one).attributes.merge(id: nil))
      device.reload

      assert_not_equal(original_last_seen_at, device.last_seen_at)
    end
  end
end
