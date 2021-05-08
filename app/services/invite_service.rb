class InviteService

  class << self

    def create sender, params
      invite = Invite.new params
      invite.sender = sender 
      invite.topic = Topic.where(id: params[:topic_id]).first
      invite.save!
      if invite.has_topic?
        InviteMailer.with(id: invite.id).topic_invite_email.deliver_later
      else
        InviteMailer.with(id: invite.id).invite_email.deliver_later
      end
      invite
    end
  end
end
