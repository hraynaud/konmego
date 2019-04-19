class Api::V1::ProjectsController < ApplicationController

  before_action :authenticate_request

  def index
    render json: {project: "blah"}
  end
end

