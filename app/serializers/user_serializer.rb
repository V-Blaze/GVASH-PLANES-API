class UserSerializer
  include JSONAPI::Serializer
  extend JsonWebToken
  attributes :name, :email, :id

  meta do |user|
    { token: jwt_encode(user_id: user.id) }
  end
end
