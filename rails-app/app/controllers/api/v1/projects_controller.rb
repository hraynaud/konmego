module Api
  module V1
    class ProjectsController < ApplicationController
      def index
        render json: ProjectSerializer.new(current_user.projects)
      end

      def create
        project = ProjectService.create(current_user, project_params)
        render json: ProjectSerializer.new(project)
      end

      def show
        project = ProjectService.find_by_id(params[:id])
        render json: ProjectSerializer.new(project)

      def update
        current_user.projects.update project_params
      end

      def project_params
        params.require(:project).permit(
          :name, :description, :start_date,
          :deadline, :topic, { progress: [], tasks: [{}] }
        )
      end
    end
  end
end
