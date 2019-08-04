class Api::V1::SkillSearchController < ApplicationController

  before_action :authenticate_request

  def index
    projects = NetworkSearchService.find_skill(current_user,params[:topic])
    render json: projects.as_json 
  end

end

