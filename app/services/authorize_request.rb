# frozen_string_literal: true

#   This class authorizes all api requests and all the requests
#   have valid token and user payload.
#
#   #call is an entry method that returns a valid user object when valid
#   and raises an error when invalid.
#
#   If the user exists in the database, the object returned is memoized to
#   avoid refetching the user again if the first call is still valid.
#   Technique to increase performance.

class AuthorizeRequest
  def initialize(headers = {})
    @headers = headers
  end

  def call
    { user: user }
  end

  private

  attr_accessor :headers

  def user
    @user ||= User.find(decode_token[:sub]) if decode_token
  rescue ActiveRecord::RecordNotFound => e
    raise "Invalid token!: #{e}"
  end

  def decode_token
    @decode_token ||= JsonWebToken.decode(auth_header)
  end

  def auth_header
    return headers[:Authorization].split.last if headers[:Authorization].present?
  rescue JWT::DecodeError => e
    raise 'Unauthorized!', e
  end
end
