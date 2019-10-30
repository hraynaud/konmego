class Api::V1::PeopleController < ApplicationController

  def index
    render json: PersonSerializer.new(group).serialized_json
  end

  private

  def group
    current_user.send(params[:group].to_sym)
  end
end
