require 'jwt'

module JsonWebToken
  extend ActiveSupport::Concern
  # SECRET_KEY = Rails.application.secrets.secret_key_base
  SECRET_KEY = Rails.application.credentials.secret_key_base
  ENCODING = 'HS512'.freeze
  def jwt_encode(payload, exp = 7.days.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY, ENCODING)
  end

  def jwt_decode(token)
    decoded = JWT.decode(token, SECRET_KEY, true, { algorithm: ENCODING })[0]
    HashWithIndifferentAccess.new decoded
  end
end
