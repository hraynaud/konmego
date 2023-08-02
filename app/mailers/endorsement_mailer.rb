class EndorsementMailer < ApplicationMailer
  before_action :set_params
  default from: 'notifications@example.com'
  
  MEMBER_ENDORSEMENT_MSG = "You've received a new endorsement from "
  NON_MEMBER_ENDORSEMENT_MSG = "You've been invited to join konmego"

  def member_email
    @msg = message
    mail(to: @endorsement.endorsee.email, subject: msg)
  end

  def non_member_email
    @msg = "#{NON_MEMBER_ENDORSEMENT_MSG}#{@thing}"
    mail(to: @endorsement.endorsee.email, subject: msg)
  end

  def set_params
    @endorsement = params[:endorsement]
  end

  def message
    "#{MEMBER_ENDORSEMENT_MSG}#{@endorsement.endorser} for your experience and knowledge in #{@endorsement.topic_name}"
  end

  
end
