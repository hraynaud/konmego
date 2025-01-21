class InviteService

  class << self

    def create sender, params
      invite = build_invite(sender,params)
      InviteMailer.with(id: invite.id).invite_email.deliver_later
      invite
    end

    def accept invite
    end



    private
 

    def build_invite sender, params
      invite = Invite.new
      invite.sender = sender 
      
      invite.email = params[:email]
      invite.first_name = params[:first_name]
      invite.last_name = params[:last_name]
      invite.expiration = 2.weeks.from_now

      invite.save!
      invite
    end

    # def accept id
    #   invite = Invite.where(id: id)
    #   if invite && invite.expiration > Time.now
    #      registration =  RegistrationService.create_from_invite invite                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
    #      invite.status = "accepted"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
    #   else
    #   end
    # end
  end
end
