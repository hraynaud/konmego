
class Api::V1::InvitesController < ApplicationController


  def create
    InviteService.create current_user, rubify_keys(invite_params)
  end

  def accept
    invite = Invite.find(params[:id])
    InviteService.accept invite

  end


  def invite_params
    params.require(:invite).permit(:firstName, :lastName, :email, :topicId)
  end

end
