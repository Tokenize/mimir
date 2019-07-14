require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "populates auth_token for new users" do
    user = User.create!(
      email: 'user@example.com', first_name: 'Some', last_name: 'User',
      password: '123456',
    )

    assert user.auth_token.present?
  end
end
