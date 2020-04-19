class Admins::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def admin_google
      @admin = Admin.from_omniauth(request.env['omniauth.auth'])

      if @admin&.persisted?
        flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
        sign_in_and_redirect @admin, event: :authentication
      else
        session['devise.google_data'] = request.env['omniauth.auth'].except(:extra) # Removing extra as it can overflow some session stores
        redirect_to new_admin_session_url, alert: 'Utilice la cuenta Google autorizada por Citas.cc'
      end
  end
end