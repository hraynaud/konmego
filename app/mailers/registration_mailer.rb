class RegistrationMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def confirm_email registration
    @registration = regisgtration
    mail(to: registration.email, subject: 'Confirm your email')
  end

  def welcome_email person
    @person = person
    mail(to: person.email, subject: 'Thank you for downloading this app')
  end


end
