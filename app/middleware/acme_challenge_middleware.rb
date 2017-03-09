class AcmeChallengeMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    if acme_challenge_request? && acme_request_token.present?
      [200, { 'Content-Type' => 'text/plain' }, [acme_request_token]]
    else
      @app.call(env)
    end
  end

  private

  def acme_challenge_request?
    env['PATH_INFO'].starts_with? acme_path_prefix
  end

  def acme_request_key
    s[acme_path_prefix.length..-1].join
  end

  def acme_request_token
    acme_data[acme_request_key]
  end

  def acme_path_prefix
    '/.well-known/acme-challenge/'
  end

  def acme_data
    {}.tap do |data|
      if ENV['ACME_KEY'] && ENV['ACME_TOKEN']
        data[ENV['ACME_KEY']] = ENV['ACME_TOKEN']
      else
        ENV.each do |k, v|
          if d = k.match(/^ACME_KEY_([0-9]+)/)
            index = d[1]
            data[v] = ENV["ACME_TOKEN_#{index}"]
          end
        end
      end
    end
  end
end
