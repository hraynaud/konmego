class Api::V1::EndorsementsController < ApplicationController
  before_action :find_endorsement, except:[:index, :create]
  before_action :validate_params, only:[:create]

  def index
    render json: EndorsementService.by_status(for_user,params[:status])
  end

  def search

  end

  def create

    endorsement = EndorsementService.create(
      current_user,
      {
        endorsee_id: params[:endorsee_id], 
        topic_id: params[:topic_id], 
        first_name: params.dig(:new_person,:first),
        last_name: params.dig(:new_person,:last),
        email: params.dig(:new_person,:identity, :email),
        new_topic_name: params.dig(:new_topic, :name),
        new_topic_category: params.dig(:new_topic, :category)
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

  def destroy
    EndorsementService.destroy(@endorsement) ? json_response({}, :ok) : respond_with_error("unable to delete endorsement with id #{@endorsement.id}")
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
    params[:new_topic]
  end

  def topic_id_provided?
    params[:topic_id]
  end

  def endorsee_id_provided?
    params[:endorsee_id]
  end

  def new_endorsee_provided?
    params[:new_person]
  end

  def find_endorsement
    @endorsement = EndorsementService.find(params[:id])
    raise ActiveGraph::Node::Labels::RecordNotFound if @endorsement.nil?
  end

  def endorsement_params
    params.permit(:id,
                  :endorsee_id, :topic_id,
                  new_person: [ :first, :last, identity: [:email]],
                  new_topic: [:name, :description]
                 )
  end

end

