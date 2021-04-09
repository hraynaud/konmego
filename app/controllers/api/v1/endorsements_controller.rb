class Api::V1::EndorsementsController < ApplicationController
  before_action :find_endorsement, except:[:index, :create]

  def index
    render json: current_user.endorsees
  end

  def create
    render json: EndorsementService.create(
      current_user,
      {
        endorsee_id: params[:endorseeId], 
        topic_id: params[:topicId], 
        new_person_first_name: params.dig(:newPerson,:first),
        new_person_last_name: params.dig(:newPerson,:last),
        new_person_email: params.dig(:newPerson,:email),
        topic_name: params.dig(:newTopic, :name),
        topic_category: params.dig(:newTopic, :category)
      }
    )
  end

  def accept
    render json: EndorsementService.accept(@endorsement)
  end

  def decline
    render json: EndorsementService.decline(@endorsement)
  end

  private


  def endorsement_params
    params.permit(
      :endorseeId, :topicId,
      newPerson: [ :first, :last, identity: [:email]],
      newTopic: [:name, :description]
    )
  end

end

