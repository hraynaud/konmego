class RegistrationController < ApplicationController
  skip_before_action :authenticate_request

  def create
    @person = Person.new(mapped_params[:person])
    @person.identity = Identity.new(mapped_params[:identity])

    if @person.valid? &&  @person.identity.valid?
      jwt = Authentication.register @person
      respond_with_token jwt
    else
      @person.errors.merge! @person.identity.errors
      respond_with_model_error @person
    end
  end

  def identity_params
    params.permit(:email, :password, :confirmPassword, :firstName, :lastName ) 
  end

  def mapped_params
    {
      identity: {
        email: identity_params[:email], 
        password: identity_params[:password],
      },
      person: {
        first_name: identity_params[:firstName],
        last_name: identity_params[:lastName]
      }
    }
  end

end
