# frozen_string_literal: true

#   This singleton class wraps JWT to provide token encoding and decoding methods.
#   The encode method is responsible for creating tokens based on a payload and also
#   define the token life time.
#
#   Encoding uses the same HMAC secret to decode the token back to a payload.
#
#   HMAC_SECRET, Hash-based message authentication code, is unique for every
#   Rails application hence used to sign the token.
#
#   Failures may happen during decoding due to expiration period or validation error.

class JsonWebToken
  HMAC_SECRET = Rails.application.secret_key_base

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, HMAC_SECRET)
  end

  def self.decode(token)
    body = JWT.decode(token, HMAC_SECRET).first
    HashWithIndifferentAccess.new(body)
  rescue JWT::DecodeError => e
    raise JWT::DecodeError, e
  end
end
