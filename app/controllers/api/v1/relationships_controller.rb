class Api::V1::RelationshipsController < ApplicationController

  def index
    render json: PersonSerializer.new(relationship_group).serializable_hash.to_json
  end

  def create

  end

  def show
    person = params[:id] ? Person.find_by_id(params[:id]) : current_user
    PersonSerializer.new person
  end

  def edit
  end

  def update

  end
  private

  def relationship_group
    current_user.send(params[:relationship_group].to_sym)
  end



  def person_params
    params.permit(
      :id,
    )
  end

end
