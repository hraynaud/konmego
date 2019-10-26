class Api::V1::EndorsementsController < ApplicationController

  def index
    current_users.endorsees
  end

  def create
    endorsement =  EndorsementService.create endorsement_params.merge({endorserId: current_user.id})
    render json: endorsement 
  end


  def endorsement_params
    params.permit(
      :endorseeId, :topicId,
      newPerson: [ :first, :last, :email],
      newTopic: [:name, :description]
    )
  end

end

