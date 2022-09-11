class Api::V1::TopicContactsController < ApplicationController

  def index
    results = EndorsementSearchService.paths_to_resource(current_user, params[:topic])
    render json: results.to_json
  end

end




