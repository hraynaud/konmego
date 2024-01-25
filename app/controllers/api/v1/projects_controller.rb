module Api
  module V1
    class ProjectsController < ApplicationController
      def index
        render json: {
          projects: ProjectSerializer.new(current_user.projects)
        }
      end

      def create
        project = ProjectService.create(current_user, project_params)
        json_response(project.to_json, :ok)
      end

      def show
        options = { params: { current_user: current_user } }
        project = ProjectService.find_by_id(params[:id])
        render json: ProjectSerializer.new(project).serializable_hash.to_json
      end

      def update
        current_user.projects.update project_params
      end

      def project_params
        params.require(:project).permit(
          :name, :description, :start_date,
          :deadline, :topic
        )
      end
    end
  end
end
