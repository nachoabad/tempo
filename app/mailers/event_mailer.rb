class EventMailer < ApplicationMailer
  def new_email
    @event  = params[:event]
    @user   = @event.user
    @admin  = @event.admin

    mail(to: [@user.email, @admin.email], subject: "Nueva Cita #{@event.name}")
  end
end
