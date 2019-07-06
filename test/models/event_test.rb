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
end
