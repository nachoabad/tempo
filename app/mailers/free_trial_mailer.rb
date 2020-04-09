class FreeTrialMailer < ApplicationMailer
  def new_email
    @free_trial  = params[:free_trial]

    mail(to: "liao2512@gmail.com", subject: "Nuevo Free Trial Citas.cc")
  end
end
