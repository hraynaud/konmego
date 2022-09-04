class Api::V1::EndorsementsController < ApplicationController
  before_action :find_endorsement, except:[:index, :create]
  before_action :validate_params, only:[:create]

  def index
    render json: EndorsementSerializer.new(EndorsementService.search_by_status(current_user,params[:status])).serializable_hash.to_json
  end

  def create
    endorsement = EndorsementService.create(
      current_user,
      {
        endorsee_id: params[:endorseeId], 
        topic_id: params[:topicId], 
        first_name: params.dig(:newPerson,:first),
        last_name: params.dig(:newPerson,:last),
        email: params.dig(:newPerson,:identity, :email),
        new_topic_name: params.dig(:newTopic, :name),
        new_topic_category: params.dig(:newTopic, :category)
      }
    )
    render json: endorsement
  end

  def accept
    render json: EndorsementService.accept(@endorsement)
  end

  def decline
    render json: EndorsementService.decline(@endorsement)
  end

  private

  def validate_params
    render :json => { :errors =>["Invalid parameters provided"] }, :status => :unprocessable_entity if invalid_params_provided?
  end

  def invalid_params_provided?
    has_invalid_topic_params? || has_invalid_endorsee_params?
  end 

  def has_invalid_topic_params?
    both_topic_id_and_new_topic_provided? || neither_new_topic_name_nor_topic_id_provided?
  end

  def has_invalid_endorsee_params?
    both_new_person_and_person_id_provided? || neither_new_person_nor_person_id_provided?
  end
 
  def both_topic_id_and_new_topic_provided?
    topic_id_provided? && new_topic_provided?
  end

  def neither_new_topic_name_nor_topic_id_provided?
    !(topic_id_provided? || new_topic_provided?)
  end

  def both_new_person_and_person_id_provided?
    endorsee_id_provided? && new_endorsee_provided?
  end

  def neither_new_person_nor_person_id_provided?
    !(endorsee_id_provided? || new_endorsee_provided?)
  end

  def new_topic_provided?
    params[:newTopic]
  end

  def topic_id_provided?
    params[:topicId]
  end

  def endorsee_id_provided?
    params[:endorseeId]
  end

  def new_endorsee_provided?
    params[:newPerson]
  end

  def find_endorsement
    @endorsement = Endorsement.find(params[:id])
  end

  def endorsement_params
    params.permit(
      :endorsee_id, :topic_id,
      newPerson: [ :first, :last, identity: [:email]],
      new_topic: [:name, :description]
    )
  end

end

