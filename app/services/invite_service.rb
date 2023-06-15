class InviteService

  class << self

    def create sender, params
      invite = Invite.new
      invite.sender = sender 
      topic = Topic.where(id: params[:topic_id]).first
      topic_name = topic.try(:name) || params[:new_topic_name]
      invite.topic_name = topic_name
   
      endorsee = Person.where(id: params[:endorsee_id]).first

      if endorsee
        invite.email =endorsee.email
        invite.email =endorsee.first_name
        invite.email =endorsee.last_name
      else 
        invite.email = params[:email]
        invite.first_name = params[:first_name]
        invite.last_name = params[:last_name]
      end
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
