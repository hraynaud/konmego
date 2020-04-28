class Api::V1::ProjectSearchController < ApplicationController

  def index
    
  end

  def search
    render json: ProjectSearchService.by_topic(params[:topic])
  end

  def search_params
    params.permit(:topic, :visibility, :person_id, :depth ) 
  end
end
