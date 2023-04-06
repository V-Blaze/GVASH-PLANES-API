class UserSerializer
  include JSONAPI::Serializer
  extend JsonWebToken
  attributes :name, :email

  meta do |user|
    { token: jwt_encode(user_id: user.id) }
  end
end
