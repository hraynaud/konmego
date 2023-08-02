class RegistrationService

  class << self

    def create params
      reg = build_registration params
      reg.save!
      RegistrationMailer.with(id: reg.id).confirm_email.deliver_later
      reg
    end

   
    def confirm id, code, password, invite_code = nil
      person = Person.where(id: id).first
      if person && confirmationValid?(person, code, password)
        person.status = "confirmed"
        person.inviter = find_by_invite_code(invite_code)
        RegistrationMailer.welcome_email(person.id).deliver_later
        person.save
        login(person)
      else
        raise "Invalid confirmation credentials"
      end
    end


    private

    def confirmationValid? person, code, password
      person.reg_code == code && person.authenticate(password)
    end

    def build_registration params
      registrant = PersonService.create(params)
      registrant.status= "pending"
      registrant.reg_code = generate_validation_code
      registrant.reg_code_expiration = 1.day.from_now
      registrant.inviter = get_invitation_sender params[:invite_code]
      registrant
    end

    def get_invitation_sender invite_code=nil
      if(invite_code.present?)
        invite = Invite.where(id: invite_code).first
        if invite
          invite.sender
        end
      end
    end

    def find_by_invite_code(invite_code)
      invite = Invite.where(id: invite_code).first
      invite ? invite.sender : nil
    end

    def person_params
      params.except(:new_topic_name,:new_topic_category)
    end

    def create_person person
      PersonService.create person
    end

    def login person
      Authentication.login_success person
    end

    def generate_validation_code
      Authentication.generate_validation_code
    end
 
   

  end
end
