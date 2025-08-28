class RegistrationController < ApplicationController
  skip_before_action :authenticate_request
  # before_action :validate_confirmation_password, only:[:create]

  def create
    reg = RegistrationService.create registration_params.except(:confirm_password)
    resp = Authentication.login_success reg
    # TODO: this should only activate after confirmation
    respond_with_token resp.jwt
  end

  def confirm
    auth = RegistrationService.confirm(params[:id], params[:code], params[:password], params[:invite_code])
    respond_with_token auth.jwt
  end

  def validate_confirmation_password
    params[:password] == params[:confirm_password]
  end

  def registration_params
    params.permit(:email, :password, :confirm_password, :first_name, :last_name, :code, :id, :invite_code)
  end
end
