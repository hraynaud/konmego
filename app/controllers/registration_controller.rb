class RegistrationController < ApplicationController
  skip_before_action :authenticate_request

  def create
    person = Registration.register registration_params

    if person.errors.empty?
      resp = Authentication.login_success person.identity
      PersonMailer.with(person: person).welcome_email.deliver_later
      respond_with_token resp.jwt
    else
      respond_with_model_error person
    end
  end

  def registration_params
    params.permit(:email, :password, :confirmPassword, :firstName, :lastName ) 
  end
end
