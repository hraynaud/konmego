class Api::V1::EndorsementsController < ApplicationController

  def index
    current_users.endorsees
  end

  def create
    render json: EndorsementService.create(params_with_user)
  end

  private

  def params_with_user
    HashWithIndifferentAccess.new({
      endorser_id: current_user.id
    }).merge( rubify_keys(endorsement_params.to_h))

  end

  def endorsement_params
    params.permit(
      :endorseeId, :topicId,
      newPerson: [ :first, :last, :email],
      newTopic: [:name, :description]
    )
  end

end

