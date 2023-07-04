class Api::V1::TopicContactsController < ApplicationController

  def index
    results = EndorsementSearchService.search(current_user, params[:topic])
    render json: results.to_json
  end

end




