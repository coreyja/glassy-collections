# frozen_string_literal: true
Clearance.configure do |config|
  config.cookie_domain = '.glassycollections.com'
  config.mailer_sender = 'reply@example.com'
  config.routes = false
  config.rotate_csrf_on_sign_in = true
end
