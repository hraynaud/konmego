class RegistrationController < ApplicationController
  skip_before_action :authenticate_request

  def create
     identity = Identity.new(mapped_params)
     if identity.valid?
       identity.save 
       jwt = Authentication.jwt_for identity
       respond_with_token jwt
     else
       respond_with_model_error identity
     end
  end

  def identity_params
    params.permit(:email, :password, :confirmPassword) 
  end

  def mapped_params
    {
      email: identity_params[:email], 
      password: identity_params[:password],
    }
  end
end
