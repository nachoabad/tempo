class EventMailer < ApplicationMailer
  def new_email
    @event  = params[:event]
    @user   = @event.user
    @admin  = @event.admin

    mail(to: [@user.email, @admin.email], subject: "Cita #{@event.name} #{I18n.l(@event.date, format: :short)}")
  end
end
