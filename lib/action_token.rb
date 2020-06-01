# ActionToken is a JWT wrapper for tokens that can be sent through email and enable one-click
# actions without a login step.
module ActionToken
  ISSUER = 'bys.rvs.com'
  ALGORITHM = 'HS256'

  SIGNING_KEY = Rails.application.key_generator.generate_key('action-token')

  def self.encode(user_id, scope:, **claims)
    payload = claims.merge(
      iss: ISSUER,
      aud: ISSUER,
      sub: user_id,
      iat: Time.now.to_i,
      exp: Time.now.to_i + (4 * 7 * 3600),
      scope: scope,
    )

    JWT.encode(payload, SIGNING_KEY, ALGORITHM)
  end

  # a token will not parse unless it is entirely valid
  def self.decode(str, scope:)
    expectations = {
      algorithm: ALGORITHM,
      iss: ISSUER,
      verify_iss: true,
      aud: ISSUER,
      verify_aud: true,
    }

    claims, _header = *JWT.decode(str, SIGNING_KEY, true, expectations)

    claims
  end
end