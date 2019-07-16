require 'test_helper'

class Api::DevicesControllerTest < ActionDispatch::IntegrationTest
  test "#update without an auth_token fails" do
    put '/api/devices/42', params: { foo: :bar, format: :json }
  end

  test "#update with auth_token but without device fails" do
    assert_raises(ActionController::RoutingError) do
      put '/api/devices', params: { auth_token: :foo, format: :json }
    end
  end

  test "#update with auth_token and device updates last_seen_at" do
    auth_token = users(:one).auth_token
    device = users(:one).devices.first
    attrs = { auth_token: auth_token, device: device.uuid, format: :json }

    future_time = 5.minutes.from_now.change(usec: 0)

    travel_to(future_time) do
      put "/api/devices/#{device.id}", params: attrs
    end

    device.reload

    assert response.accepted?
    assert device.last_seen_at == future_time
  end
end
