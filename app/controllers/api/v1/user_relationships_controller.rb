
class Api::V1::UserRelationshipsController < ApplicationController

  def index

    render json: PersonSerializer.new(group).serializable_hash.to_json
  end


  private

  def group
    current_user.send(params[:group].to_sym)
  end

  def person_params
    params.permit(
      :group,
    )
  end


end
