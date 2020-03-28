class RegistrationController < ApplicationController
  skip_before_action :authenticate_request

  def create
    person = Registration.register registration_params

    if person.errors.empty?
      Authentication.login_by_password person.identity.email, person.identity.password
    else
      respond_with_model_error person
    end
  end

  def registration_params
    params.permit(:email, :password, :confirmPassword, :firstName, :lastName ) 
  end
end
