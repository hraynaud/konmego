class RegistrationService

  class << self

    def create params
      reg = build_registration params
      reg.save!
      RegistrationMailer.with(reg_id: reg.identity.id).confirm_email.deliver_later
      reg
    end

    def confirm id, code, password
      registration = Registration.where(id: id).first
      if registration && confirmationValid?(registration, code, password)
        registration.status = "confirmed"
        registration.save
        person = create_person(registration)
        RegistrationMailer.welcome_email(registration.id).deliver_later
        login(person)

      else
        raise "Invalid confirmation credentials"
      end
    end


    private

    def confirmationValid? registration, code, password
      registration.reg_code == code && registration.authenticate(password)
    end

   
    def build_registration params

      reg = Registration.new
      reg.status= "pending"
      reg. reg_code = generate_validation_code
      reg.reg_code_expiration = 1.day.from_now
      reg.identity = Identity.new params.except(:endorser_id, :topic_id)
      reg
    end

    def person_params
      params.except(:new_topic_name,:new_topic_category)
    end

    def create_person registration
      PersonService.create registration
    end

    def login person
      Authentication.login_success person.identity
    end

    def generate_validation_code
      6.times.map{rand(10)}.join
    end

  end
end
