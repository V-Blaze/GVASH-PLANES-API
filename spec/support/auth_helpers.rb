module AuthHelpers
  def user_login(user)
    secret = Rails.application.secrets.secret_key_base

    encoding = 'HS512'

    request.headers['Authorization'] =
      JWT.encode({ user_id: user.id }, secret, encoding)
  end
end
