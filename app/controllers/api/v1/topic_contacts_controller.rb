class Api::V1::TopicContactsController < ApplicationController

  def index
  end

  def show
    paths = TopicSearchService.paths_and_connections_from(current_user,params[:topic])
    render json: paths.as_json 
  end

end

