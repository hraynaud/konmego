class RegistrationService

  class << self

    def create params
      reg = Identity.new params
      reg.reg_code = generate_validation_code
      reg.save!
      RegistrationMailer.with(reg_id: reg.id).confirm_email.deliver_later
    end

    def confirm registration
      person = create_person
      RegistrationMailer.welcome_email(person).deliver_later
      login(person)
    end

    private

    def create_person
      PersonService.create(
        registration.first_name,
        registration.last_name,
        registration.email,
        registration.password
      )

    end

    def login person
      Authentication.login_success person.identity
    end

    def generate_validation_code
      6.times.map{rand(10)}.join
    end

  end
end
