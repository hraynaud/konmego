class Api::V1::ProjectsController < ApplicationController

  before_action :authenticate_request

  def index
    projects = Project.all
    render json: projects.as_json 
  end
end

