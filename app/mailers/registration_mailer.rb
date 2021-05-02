class RegistrationMailer < ApplicationMailer
  default from: 'notifications@example.com'

  REG_WELCOME_MSG = 'Welcome to konmego.com'
  REG_CONFIRM_MSG = 'Confirm your email'

  def confirm_email id
    @identity = Registration.find(id) 
    mail(to: @identity.email, subject: REG_CONFIRM_MSG)
  end

  def welcome_email
    @identity = Registration.find(params[:id]) 
    mail(to: @identity.email, subject: REG_WELCOME_MSG)
  end

end
