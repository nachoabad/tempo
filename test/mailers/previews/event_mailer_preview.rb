# Preview all emails at http://localhost:3000/rails/mailers/event_mailer
class EventMailerPreview < ActionMailer::Preview
  def new_email
    EventMailer.with(event: Event.first).new_email
  end
end
