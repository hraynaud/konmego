class RegistrationMailer < ApplicationMailer
  default from: 'notifications@example.com'

  REG_WELCOME_MSG = "Welcome to konmego.com"
  REG_CONFIRM_MSG = "Confirm your email"
  REG_INVITE_MSG = "You've been invited to join konmego"
  REG_ENDORSEMENT_INVITE_MSG = "You've been invited to join konmego as"

  before_action do
    @registration = Person.find(params[:id]) 
  end

  def confirm_email
    mail(to: @registration.email, subject: REG_CONFIRM_MSG)
  end

  def welcome_email
    mail(to: @registration.email, subject: REG_WELCOME_MSG)
  end

  def invite_email
    mail(to: @registration.email, subject: REG_INVITE_MSG)
  end

  def endorsement_invite_email
    mail(to: @registration.email, subject: REG_ENDORSEMENT_INVITE_MSG)
  end
end
