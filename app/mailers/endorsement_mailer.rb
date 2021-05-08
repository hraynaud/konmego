class EndorsementMailer < ApplicationMailer
  default from: 'notifications@example.com'

  REG_WELCOME_MSG = 'Welcome to konmego.com'
  REG_CONFIRM_MSG = 'Confirm your email'

  def accept id
    @identity = Endorsement.find(id) 
    mail(to: @identity.email, subject: REG_CONFIRM_MSG)
  end

  def accept_and_register id
    @identity = Endorsement.find(id) 
    mail(to: @identity.email, subject: REG_CONFIRM_MSG)
  end

  #def decline
    #@identity = Endorsement.find(params[:id]) 
    #mail(to: @identity.email, subject: REG_WELCOME_MSG)
  #end

end
