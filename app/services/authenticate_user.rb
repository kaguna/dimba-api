# frozen_string_literal: true

#   The class authenticates users via combination of
#   email and password.
#
#   #call is an entry point method that returns a token
#   when user credentials are valid and raise if invalid
#
#   If the user exists, we use the id to create the token
#   with user_id as the payload.

class AuthenticateUser

  class InvalidCredentials < StandardError; end

  def initialize(email, password)
    @email = email
    @password = password
  end

  def call

    JsonWebToken.encode(payload) if user
  end

  private

  attr_accessor :email, :password

  def user
    user = User.find_by(email: email)
    return user if user&.authenticate(password)

    raise 'Invalid credentials!'
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
