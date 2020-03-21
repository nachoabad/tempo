Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, Rails.application.credentials.google[:key], Rails.application.credentials.google[:secret]
  on_failure { |env| AuthenticationsController.action(:failure).call(env) }
end