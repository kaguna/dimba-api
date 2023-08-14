module AuthenticationSpecHelper
  def authenticated_header(payload)
    {
      Authorization: "Bearer #{generate_token(payload)}"
    }
  end

  def generate_token(payload)
    JsonWebToken.encode(payload)
  end

  def generate_expired_token(payload)
    JsonWebToken.encode({ payload: payload }, 24.hours.ago)
  end

  def payload
    {
      sub: user.id,
      email: user.email,
      username: user.username,
      role: user.role.name
    }
  end
end
