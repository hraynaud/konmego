class Api::V1::PeopleController < ApplicationController

  def index
    render json: PersonSerializer.new(relationship_group).serialized_json
  end

  private

  def relationship_group
    current_user.send(params[:relationship_group].to_sym)
  end
end
