require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "populates auth_token for new users" do
    user = User.create!(
      email: 'user@example.com', first_name: 'Some', last_name: 'User',
      password: '123456',
    )

    assert user.auth_token.present?
  end

  test "it allows nil time_zone" do
    user = User.new(
      email: 'user@example.com', first_name: 'Some', last_name: 'User',
      password: '123456', time_zone: nil
    )

    user.valid?

    assert user.errors[:time_zone].blank?
  end

  test "it allows valid time_zone" do
    user = User.new(
      email: 'user@example.com', first_name: 'Some', last_name: 'User',
      password: '123456', time_zone: "Eastern Time (US & Canada)"
    )

    assert user.valid?
  end

  test "it does not allow invalid time_zone" do
    user = User.new(
      email: 'user@example.com', first_name: 'Some', last_name: 'User',
      password: '123456', time_zone: "Foobar"
    )

    assert !user.valid?
  end
end
