class AcmeChallengeMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    if acme_challenge_request?(env) && acme_request_token(env).present?
      [200, { 'Content-Type' => 'text/plain' }, [acme_request_token(env)]]
    else
      @app.call(env)
    end
  end

  private

  def acme_challenge_request?(env)
    env['PATH_INFO'] && env['PATH_INFO'].starts_with?(acme_path_prefix)
  end

  def acme_request_key(env)
    env['PATH_INFO'][acme_path_prefix.length..-1]
  end

  def acme_request_token(env)
    acme_data[acme_request_key(env)]
  end

  def acme_path_prefix
    '/.well-known/acme-challenge/'
  end

  def acme_data
    {}.tap do |data|
      if ENV['ACME_KEY'] && ENV['ACME_TOKEN']
        data[ENV['ACME_TOKEN']] = ENV['ACME_KEY']
      else
        ENV.each do |k, v|
          if d = k.match(/^ACME_KEY_([0-9]+)/)
            index = d[1]
            data[ENV["ACME_TOKEN_#{index}"]] = v
          end
        end
      end
    end
  end
end
