class RegistrationController < ApplicationController
  skip_before_action :authenticate_request
  before_action :validate_confirmation_password, only:[:create]

  def create
    reg = RegistrationService.create rubify_keys(registration_params.except(:confirmPassword))
    json_response({id: reg.id}, :ok)
  end

  def confirm
    auth = RegistrationService.confirm(params[:id], params[:code], params[:password])
    respond_with_token auth.jwt
  end

  def validate_confirmation_password
   params[:password] == params[:confirmPassword]
  end

  def registration_params
    params.permit(:email, :password, :confirmPassword, :firstName, :lastName, :code, :id) 
  end

end
