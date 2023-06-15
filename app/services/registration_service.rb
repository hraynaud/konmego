class RegistrationService

  class << self

    def create params
      reg = build_registration params
      reg.save!
      RegistrationMailer.with(id: reg.id).confirm_email.deliver_later
      reg
    end

    def confirm id, code, password
      person = Person.where(id: id).first
      if person && confirmationValid?(person, code, password)
        person.status = "confirmed"
        person.save
        RegistrationMailer.welcome_email(person.id).deliver_later
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
      reg = Person.new
      reg.status= "pending"
      reg. reg_code = generate_validation_code
      reg.reg_code_expiration = 1.day.from_now
      reg.first_name = params[:first_name]
      reg.last_name = params[:last_name]
      reg.email = params[:email]
      reg.password = params[:password]
      reg
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
      6.times.map{rand(10)}.join
    end

  end
end
