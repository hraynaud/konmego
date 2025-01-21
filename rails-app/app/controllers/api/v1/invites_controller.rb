
class Api::V1::InvitesController < ApplicationController


  def create
    InviteService.create current_user, invite_params
  end

  def accept
    invite = Invite.find_by_id(params[:invite_token])
    if invite
      InviteService.accept invite
    else
    end
  end


  def invite_params
    params.permit(:first_name, :last_name, :email, :invite_token)
  end

end
