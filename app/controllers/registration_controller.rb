class RegistrationController < ApplicationController
  skip_before_action :authenticate_request

  def create
     person = Person.new(mapped_params)
     if person.valid?
       person.save 
       jwt = Authentication.jwt_for person
       respond_with_token jwt
     else
       respond_with_model_error person
     end
  end

  def person_params
    params.permit(:firstName, :lastName, :email, :password, :confirmPassword) 
  end

  def mapped_params
    {
      email: person_params[:email], 
      password: person_params[:password],
      first_name: person_params[:firstName],
      last_name: person_params[:lastName]
    }
  end
end
