module AuthHelpers
  def token(user)
    JWT.encode({ user_id: user.id }, Rails.application.secrets.secret_key_base, 'HS512')
  end
end
