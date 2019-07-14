require 'test_helper'

class Api::EventsControllerTest < ActionDispatch::IntegrationTest
  test "#create without an auth_token fails" do
    post '/api/events', params: { foo: :bar, format: :json }
    assert_not response.successful?
  end

  test "#create with auth_token but without device fails" do
    post '/api/events', params: { auth_token: :foo, format: :json }
    assert_not response.successful?
  end

  test "#create with auth_token and device and event succeeds" do
    auth_token = users(:one).auth_token
    device_uuid = users(:one).devices.first.uuid
    attrs = {
      auth_token: auth_token, device: device_uuid, format: :json,
      event: {
        command: '502', description: 'System Error', priority: 'critical', timestamp: Time.current
      }
    }

    post '/api/events', params: attrs
    assert response.successful?
  end

  test "#create with invalid event attributs fails" do
    auth_token = users(:one).auth_token
    device_uuid = users(:one).devices.first.uuid
    attrs = {
      auth_token: auth_token, device: device_uuid, format: :json,
      event: {
        command: '502', description: 'System Error', priority: 'critical'
      }
    }

    post '/api/events', params: attrs
    json_body = JSON.parse(response.body)

    assert response.status == 422
    assert_not json_body['error'].blank?
  end
end
