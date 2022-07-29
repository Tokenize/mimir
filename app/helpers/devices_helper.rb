module DevicesHelper
  def device_last_seen(device)
    return 'has not been seen yet' if device.last_seen_at.nil?

    "last seen #{time_ago_in_words(device.last_seen_at)} ago"
  end

  def newest_events_for_device(device)
    device.events.order(id: :desc).limit(5)
  end
end
