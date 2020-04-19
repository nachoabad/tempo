Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, Rails.application.credentials.google[:key], Rails.application.credentials.google[:secret], scope: 'userinfo.email,userinfo.profile', name: :admin_google, path_prefix: "/admins/auth"
  provider :google_oauth2, Rails.application.credentials.google[:key], Rails.application.credentials.google[:secret], scope: 'userinfo.email,userinfo.profile', name: :user_google, path_prefix: "/users/auth"
end