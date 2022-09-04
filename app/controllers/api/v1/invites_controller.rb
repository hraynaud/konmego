
class Api::V1::InvitesController < ApplicationController


  def create
    InviteService.create current_user, invite_params
  end

  def accept
    invite = Invite.find(params[:id])
    InviteService.accept invite

  end


  def invite_params
    params.require(:invite).permit(:first_name, :last_name, :email, :topic_id)
  end

end
