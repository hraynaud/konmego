class Api::V1::ProjectsController < ApplicationController
  def index
    @project = Project.all.order(created_at: :desc)
    render json: @project
  end
end

