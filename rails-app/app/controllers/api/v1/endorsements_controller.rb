class Api::V1::EndorsementsController < ApplicationController
  before_action :validate_params, only: [:create]

  def index
    render json: EndorsementService.by_status(for_user, params[:status])
  end

  def search; end

  def create # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
    endorsement = EndorsementService.create(
      current_user,
      {
        endorsee_id: params[:endorsee_id],
        topic_id: params[:topic_id],
        description: params[:description],
        first_name: params.dig(:new_person, :first),
        last_name: params.dig(:new_person, :last),
        email: params.dig(:new_person, :identity, :email),
        new_topic_name: params.dig(:new_topic, :name),
        new_topic_category: params.dig(:new_topic, :category)
      }
    )
    render json: endorsement
  end

  def accept
    handle_inbound_endorsement_response
  end

  def decline
    @endorsement = find_endorsement
    if @endorsement.endorsee != current_user
      render json: { errors: ['Invalid Operation'] },
             status: :unprocessable_entity
    end
    if @endorsement
      render json: EndorsementService.decline(@endorsement, current_user)
    else
      render json: { errors: ['Endorsement not found'] }, status: :not_found
    end
  end

  def destroy
    @endorsement = find_endorsement
    if @endorsement
      render json: EndorsementService.destroy(@endorsement, current_user)
    else
      render json: { errors: ['Endorsement not found'] }, status: :not_found
    end
  end

  private

  def handle_inbound_endorsement_response
    @endorsement = find_endorsement
    if @endorsement
      render json: EndorsementService.accept(@endorsement, current_user)
    else
      render json: { errors: ['Endorsement not found'] }, status: :not_found
    end
  end

  def validate_params
    return unless invalid_params_provided?

    render json: { errors: ['Invalid parameters provided'] },
           status: :unprocessable_entity
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

    @endorsement
  end
  # def find_endorsement
  #   @endorsement = EndorsementService.find(endorsement_params)
  # end

  def endorsement_params
    params.permit(:id,
                  :endorsee_id, :topic_id, :endorser_id, :topic_name,
                  new_person: [:first, :last, { identity: [:email] }],
                  new_topic: %i[name description])
  end
end
