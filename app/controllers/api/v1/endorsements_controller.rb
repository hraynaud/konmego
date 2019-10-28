class Api::V1::EndorsementsController < ApplicationController
  before_action :find_endorsement, except:[:index, :create]

  def index
    render json: current_users.endorsees
  end

  def create
    render json: EndorsementService.create(params_with_user)
  end

  def accept
   render json: EndorsementService.accept(@endorsement)
  end

  def decline
   render json: EndorsementService.decline(@endorsement)
  end

  private

  def find_endorsement
    @endorsement = Endorsement.find(params[:id])
  end

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

