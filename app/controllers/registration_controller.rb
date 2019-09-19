class RegistrationController < ApplicationController
  skip_before_action :authenticate_request

  def create
     person = Person.new(person_params)
     if person.valid?
       person.save 
       jwt = Authentication.jwt_for person
       respond_with_token jwt
     else
       respond_with_error person.errors.full_messages.to_sentence
     end
  end

  def person_params
    params.require(:person).permit(:first_name, :last_name, :email, :password, :password_confirmation) 
  end
end
