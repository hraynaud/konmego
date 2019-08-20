class Api::V1::TopicContactsController < ApplicationController

  before_action :authenticate_request

  def index
  end


  def show
    paths = TopicSearchService.paths_and_connections_from(current_user,params[:topic])
    render json: paths.as_json 
  end

end

