class InviteMailer < ApplicationMailer
  default from: 'notifications@example.com'

 INVITE_MSG = "You've been invited to join konmego"
 TOPIC_INVITE_MSG= "You've been invited to join Konmego and share your knowledge of "

  before_action do
    @invite = Invite.find(params[:id]) 
  end

  def invite_email
    mail(to: @invite.email, subject: INVITE_MSG)
  end


  def topic_invite_email
    msg = "#{TOPIC_INVITE_MSG}#{@thing}"
    mail(to: @invite.email, subject: msg)
  end
end
