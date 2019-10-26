class Api::V1::PeopleController < ApplicationController

  def index
    render json: PersonSerializer.new(current_user.contacts).serialized_json
  end

end
