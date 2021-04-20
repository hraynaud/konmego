class RegistrationController < ApplicationController
  skip_before_action :authenticate_request
  before_action :validate_password

  def create
    RegistrationService.create rubify_keys(registration_params.except(:confirmPassword))
  end

  def confirm_registration
    registration = Registration.find(params[:id])
    if registration 
      auth = RegistrationService.confirm(registration)
      respond_with_token auth.jwt
    else
      respond_with_model_error registration
    end
  end

  def validate_credentials
   params[:password] == params[:confirmPassword]
  end

  def registration_params
    params.permit(:email, :password, :confirmPassword, :firstName, :lastName ) 
  end
end
