module UserAuthTokenGeneration
  extend ActiveSupport::Concern

  def regenerate_auth_token!
    update!(auth_token: SecureRandom.hex)
  end
end
