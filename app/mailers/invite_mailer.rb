class InviteMailer < ApplicationMailer
  default from: 'notifications@example.com'

 INVITE_MSG = "You've been invited to join konmego"
 ENDORSEMENT_INVITE_MSG = "You've been invited to join konmego"

  before_action do
    @invite = Invite.find(params[:id]) 
  end

  def invite_email
    mail(to: @invite.email, subject: INVITE_MSG)
  end


  def endorsement_invite_email
    @msg = "#{ENDORSEMENT_INVITE_MSG}"
    mail(to: @invite.email, subject: msg)
  end
end
